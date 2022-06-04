extern "C"
{
#include "perf_lu_solve.h"
};

#include "cstring"

#include "../lu_solve.h"
#include "PerformanceTester.hpp"

namespace
{
class ArgumentRestorerLU
{
private:
  int N = 0;
  // managed memory: copy of the original arguments
  std::vector<double> A0;
  std::vector<double> b0;

  // unmanaged memory: the arguments to restore
  double *A = nullptr;
  double *b = nullptr;

public:
  ArgumentRestorerLU(int N, double *A, double *b) : N{N}, A{A}, b{b}
  {
    size_t A_s = N * N;

    A0.assign(A, A + A_s);
    b0.assign(b, b + N);
  }

  // copy back original arguments into
  void operator()()
  {
    size_t A_s = N * N;
    std::memcpy(A, A0.data(), A_s * sizeof(double));
    std::memcpy(b, b0.data(), N * sizeof(double));
  }
};

} // namespace

static PerformanceTester<lu_solve_fun_t> perf_tester;

extern "C" void add_function_LU_SOLVE(lu_solve_fun_t f, char *name, int flop)
{
  std::string nm = std::string(name);
  std::cout << "Register " << nm << "\n";
  perf_tester.add_function(f, nm, flop);
}

extern "C" int perf_test_lu_solve(int N, double *A, double *b)
{
  ArgumentRestorerLU arg_restorer{N, A, b};
  lu_initialize_memory(N);
  int input_size = N;
  int ret = perf_tester.perf_test_all_registered(std::move(arg_restorer),
                                                 input_size, N, A, b);
  lu_free_memory();
  return ret;
}
