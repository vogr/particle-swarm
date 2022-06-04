extern "C"
{
#include "perf_mmm.h"
};

#include "cstring"

#include "../lu_solve.h"
#include "PerformanceTester.hpp"

typedef void (*mmm_fun_t)(int M, int N, int K, double alpha, double *A, int LDA,
                          double *B, int LDB, double beta, double *C, int LDC);

namespace
{

class ArgumentRestorerMMM
{
private:
  int M0 = 0;
  int N0 = 0;
  int K0 = 0;
  int LDA0 = 0;
  int LDB0 = 0;
  int LDC0 = 0;

  double alpha0 = 0.;
  double beta0 = 0.;

  // managed memory: copy of the original arguments
  std::vector<double> A0;
  std::vector<double> B0;
  std::vector<double> C0;

  // unmanaged memory: the arguments to restore
  double *A = nullptr;
  double *B = nullptr;
  double *C = nullptr;

public:
  ArgumentRestorerMMM(int M, int N, int K, double alpha, double *A, int LDA,
                      double *B, int LDB, double beta, double *C, int LDC)
      : A{A}, B{B}, C{C}
  {

    M0 = M;
    N0 = N;
    K0 = K;
    LDA0 = LDA;
    LDB0 = LDB;
    LDC0 = LDC;

    A0.assign(A, A + M * K);
    B0.assign(B, B + M * K);
    C0.assign(C, C + M * K);

    alpha0 = alpha;
    beta0 = beta;
  }

  void operator()()
  {
    std::memcpy(A, A0.data(), M0 * K0 * sizeof(double));
    std::memcpy(B, B0.data(), K0 * N0 * sizeof(double));
    std::memcpy(C, C0.data(), M0 * N0 * sizeof(double));
  }
};

} // namespace

static PerformanceTester<mmm_fun_t> perf_tester;

extern "C" void add_function_MMM(mmm_fun_t f, char *name, int flop)
{
  std::string nm = std::string(name);
  std::cerr << "Register " << nm << "\n";
  perf_tester.add_function(f, nm, flop);
}

extern "C" int perf_test_mmm(int M, int N, int K, double alpha, double *A,
                             int LDA, double *B, int LDB, double beta,
                             double *C, int LDC)
{
  ArgumentRestorerMMM arg_restorer{M, N,   K,    alpha, A,  LDA,
                                   B, LDB, beta, C,     LDC};
  int input_size = M;
  return perf_tester.perf_test_all_registered(std::move(arg_restorer),
                                              input_size, M, N, K, alpha, A,
                                              LDA, B, LDB, beta, C, LDC);
}
