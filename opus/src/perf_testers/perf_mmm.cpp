extern "C"
{
#include "perf_mmm.h"
};

#include "cstring"

#include "../lu_solve.h"
#include "PerformanceTester.hpp"

typedef void (*mmm_fun_t)(int M, int N, int K, double alpha, double *A, int LDA,
                          double *B, int LDB, double beta, double *C, int LDC);

template <> class ArgumentRestorer<mmm_fun_t>
{
private:
  int M0 = 0;
  int N0 = 0;
  int K0 = 0;
  int LDA0 = 0;
  int LDB0 = 0;
  int LDC0 = 0;

  double *A0 = nullptr;
  double *B0 = nullptr;
  double *C0 = nullptr;

  double alpha0 = 0.;
  double beta0 = 0.;

public:
  ArgumentRestorer<mmm_fun_t>(int M, int N, int K, double alpha, double *A,
                              int LDA, double *B, int LDB, double beta,
                              double *C, int LDC)
  {

    M0 = M;
    N0 = N;
    K0 = K;
    LDA0 = LDA;
    LDB0 = LDB;
    LDC0 = LDC;

    A0 = (double *)std::malloc(M * K * sizeof(double));
    B0 = (double *)std::malloc(K * N * sizeof(double));
    C0 = (double *)std::malloc(M * N * sizeof(double));

    alpha0 = alpha;
    beta0 = beta;

    std::memcpy(A0, A, M * K * sizeof(double));
    std::memcpy(B0, B, K * N * sizeof(double));
    std::memcpy(C0, C, M * N * sizeof(double));
  }

  void restore_arguments(int M, int N, int K, double alpha, double *A, int LDA,
                         double *B, int LDB, double beta, double *C, int LDC)
  {
    std::memcpy(A, A0, M0 * K0 * sizeof(double));
    std::memcpy(B, B0, K0 * N0 * sizeof(double));
    std::memcpy(C, C0, M0 * N0 * sizeof(double));
  }

  ~ArgumentRestorer<mmm_fun_t>()
  {
    free(A0);
    free(B0);
    free(C0);
  }
};

static PerformanceTester<mmm_fun_t> perf_tester;

extern "C" void add_function_MMM(mmm_fun_t f, char *name, int flop)
{
  std::string nm = std::string(name);
  std::cout << "Register " << nm << "\n";
  perf_tester.add_function(f, nm, flop);
}

extern "C" int perf_test_mmm(int M, int N, int K, double alpha, double *A,
                             int LDA, double *B, int LDB, double beta,
                             double *C, int LDC)
{
  register_functions_MMM();
  return perf_tester.perf_test_all_registered(M, N, K, alpha, A, LDA, B, LDB,
                                              beta, C, LDC);
}
