extern "C"
{
  #include "perf_ge_solve.h"
};


#include "PerformanceTester.hpp"
#include "gaussian_elimination_solver.h"

static PerformanceTester<ge_solve_fun_t> perf_tester;

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