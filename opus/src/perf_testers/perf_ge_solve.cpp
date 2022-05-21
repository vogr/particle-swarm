extern "C"
{
#include "perf_ge_solve.h"
};

#include "cstring"

#include "../gaussian_elimination_solver.h"
#include "PerformanceTester.hpp"

class PerformanceTesterGE : public PerformanceTester<ge_solve_fun_t>
{
private:
  double *Ab0 = nullptr;
  double *x0 = nullptr;

  virtual void save_arguments(int N, double *Ab, double *x) override
  {
    size_t Ab_s = N * (N + 1);
    Ab0 = (double *)std::malloc(Ab_s * sizeof(double));
    x0 = (double *)std::malloc(N * sizeof(double));

    std::memcpy(Ab0, Ab, Ab_s * sizeof(double));
    std::memcpy(x0, x, N * sizeof(double));
  }

  virtual void restore_arguments(int N, double *Ab, double *x) override
  {
    size_t Ab_s = N * (N + 1);
    std::memcpy(Ab, Ab0, Ab_s * sizeof(double));
    std::memcpy(x, x0, N * sizeof(double));
  }
};

static PerformanceTesterGE perf_tester;

extern "C" void add_function_GE_SOLVE(ge_solve_fun_t f, char *name, int flop)
{
  std::string nm = std::string(name);
  std::cout << "Register " << nm << "\n";
  perf_tester.add_function(f, nm, flop);
}

extern "C" int perf_test_ge_solve(int N, double *Ab, double *x)
{
  return perf_tester.perf_test_all_registered(N, Ab, x);
}