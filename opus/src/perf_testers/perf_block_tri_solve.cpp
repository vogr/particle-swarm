extern "C"
{
#include "perf_block_tri_solve.h"
};

#include "cstring"

#include "../triangular_system_solver.h"
#include "PerformanceTester.hpp"

namespace
{

class ArgumentRestorerTRI
{
private:
  int N = 0;
  int d = 0;
  // managed memory: copy of the original arguments
  std::vector<double> Ab0;
  std::vector<double> x0;

  // unmanaged memory: the arguments to restore
  double *Ab = nullptr;
  double *x = nullptr;

public:
  ArgumentRestorerTRI(int N, int d, double *Ab, double *x) : N{N}, d{d}, Ab{Ab}, x{x}
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

static PerformanceTester<block_tri_solve_fun_t> perf_tester;

extern "C" void add_function_TRI_SYS_SOLVE(block_tri_solve_fun_t f, char *name, int flop)
{
  std::string nm = std::string(name);
  std::cout << "Register " << nm << "\n";
  perf_tester.add_function(f, nm, flop);
}

extern "C" int perf_test_tri_sys_solve(int N, int d, double *Ab, double *x)
{
  register_functions_TRI_SYS_SOLVE();
  ArgumentRestorerTRI arg_restorer{N, d, Ab, x};
  return perf_tester.perf_test_all_registered(std::move(arg_restorer), N, d, Ab,
                                              x);
}
