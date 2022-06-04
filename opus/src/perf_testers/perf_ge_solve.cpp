extern "C"
{
#include "perf_ge_solve.h"
};

#include "cstring"

#include "../gaussian_elimination_solver.h"
#include "PerformanceTester.hpp"

namespace
{

class ArgumentRestorerGE
{
private:
  int N = 0;
  // managed memory: copy of the original arguments
  std::vector<double> Ab0;
  std::vector<double> x0;

  // unmanaged memory: the arguments to restore
  double *Ab = nullptr;
  double *x = nullptr;

public:
  ArgumentRestorerGE(int N, double *Ab, double *x) : N{N}, Ab{Ab}, x{x}
  {
    size_t Ab_s = N * (N + 1);

    Ab0.assign(Ab, Ab + Ab_s);
    x0.assign(x, x + N);
  }

  void operator()()
  {
    size_t Ab_s = N * (N + 1);
    std::memcpy(Ab, Ab0.data(), Ab_s * sizeof(double));
    std::memcpy(x, x0.data(), N * sizeof(double));
  }
};

} // namespace

static PerformanceTester<ge_solve_fun_t> perf_tester;

extern "C" void add_function_GE_SOLVE(ge_solve_fun_t f, char *name, int flop)
{
  std::string nm = std::string(name);
  std::cout << "Register " << nm << "\n";
  perf_tester.add_function(f, nm, flop);
}

extern "C" int perf_test_ge_solve(int N, double *Ab, double *x)
{
  register_functions_GE_SOLVE();
  ArgumentRestorerGE arg_restorer{N, Ab, x};
  int input_size = N;
  return perf_tester.perf_test_all_registered(std::move(arg_restorer),
                                              input_size, N, Ab, x);
}
