/**
 *      _________   _____________________  ____  ______
 *     / ____/   | / ___/_  __/ ____/ __ \/ __ \/ ____/
 *    / /_  / /| | \__ \ / / / /   / / / / / / / __/
 *   / __/ / ___ |___/ // / / /___/ /_/ / /_/ / /___
 *  /_/   /_/  |_/____//_/  \____/\____/_____/_____/
 *
 *  http://www.acl.inf.ethz.ch/teaching/fastcode
 *  How to Write Fast Numerical Code 263-2300 - ETH Zurich
 *  Copyright (C) 2019
 *                   Tyler Smith        (smitht@inf.ethz.ch)
 *                   Alen Stojanov      (astojanov@inf.ethz.ch)
 *                   Gagandeep Singh    (gsingh@inf.ethz.ch)
 *                   Markus Pueschel    (pueschel@inf.ethz.ch)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see http://www.gnu.org/licenses/.
 */

#include <algorithm>
#include <iostream>
#include <list>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <time.h>
#include <vector>

#include "tsc_x86.h"
// #include "utils.h"

extern "C"
{
#include "perf_ge_solve.h"
  // void add_function_GE_SOLVE(comp_func f, char *name, int flop);
  // void register_functions_GE_SOLVE();
  // int perf_test_ge_solve(int N, double *Ab, double *x);
};

/**
 * A NOTE from your sponsor (Gavin)
 *
 * This code should be able to be stamped out with a template.
 * We could then easily create a "Performance Kernel" for each
 * library module allowing us to modularly perf test and modify each
 * of them. By adopting C calling conventions with 'extern' we can
 * call these from Julia and integrate them into our testing Suite.
 */

using namespace std;

#define NR 32
#define CYCLES_REQUIRED 1e8
#define REP 50
#define EPS (1e-3)

/* prototype of the function you need to optimize */
typedef int (*comp_func)(int N, double *Ab, double *x);
static double get_perf_score(comp_func f);
static double perf_test(comp_func f, string desc, int flops, int N, double *Ab,
                        double *x);

/* Global vars, used to keep track of student functions */
static vector<comp_func> userFuncs;
static vector<string> funcNames;
static vector<int> funcFlops;
static int numFuncs = 0;

/*
 * Registers a user function to be tested by the driver program. Registers a
 * string description of the function as well
 */
extern "C" void add_function_GE_SOLVE(comp_func f, char *name, int flop)
{
  string nm = string(name);
  userFuncs.push_back(f);
  // funcNames.emplace_back(nm);
  funcNames.push_back(nm);
  funcFlops.push_back(flop);
  numFuncs++;
}

/*
 * Checks the given function for validity. If valid, then computes and
 * reports and returns the number of cycles required per iteration
 *
 * FIXME f is going to modify the contents of the functions. XXX
 * thus each iteration is actually solving a *different* problem.
 */
static double perf_test(comp_func f, string desc, int flops, int N, double *Ab,
                        double *x)
{
  double cycles = 0.;
  long num_runs = 10;
  double multiplier = 1;
  myInt64 start, end;

  // HACK!
  int W = N * (1 + N) * sizeof(double);
  double *Ab_base = (double *)aligned_alloc(32, W);
  memcpy(Ab_base, Ab, W); // Save the original matrix

  // Warm-up phase: we determine a number of executions that allows
  // the code to be executed for at least CYCLES_REQUIRED cycles.
  // This helps excluding timing overhead when measuring small runtimes.
  do
  {
    num_runs = num_runs * multiplier;
    start = start_tsc();
    for (size_t i = 0; i < num_runs; i++)
    {
      f(N, Ab, x);
    }
    end = stop_tsc(start);

    cycles = (double)end;
    memcpy(Ab, Ab_base, W);
    multiplier = (CYCLES_REQUIRED) / (cycles);

  } while (multiplier > 2);

  list<double> cyclesList;

  // Actual performance measurements repeated REP times.
  // We simply store all results and compute medians during post-processing.
  double total_cycles = 0;
  for (size_t j = 0; j < REP; j++)
  {
    for (size_t i = 0; i < num_runs; ++i)
    {
      start = start_tsc();
      f(N, Ab, x);
      end = stop_tsc(start);
      cycles = ((double)end);
      total_cycles += cycles;
      cyclesList.push_back(cycles); // XXX why have this
      memcpy(Ab, Ab_base, W);
    }
  }
  total_cycles /= (REP * num_runs);
  cycles = total_cycles;

  return cycles;
}

extern "C" int perf_test_ge_solve(int N, double *Ab, double *x)
// int main(int argc, char **argv)
{
  cout << "Starting performance tests.";
  double perf;
  int i;

  register_functions_GE_SOLVE();

  if (numFuncs == 0)
  {
    cout << endl;
    cout << "No functions registered - nothing for driver to do" << endl;
    cout << "Register functions by calling register_func(f, name)" << endl;
    cout << "in register_funcs()" << endl;
    return -1;
  }

  cout << numFuncs << " functions registered." << endl;

  for (i = 0; i < numFuncs; i++)
  {
    perf = perf_test(userFuncs[i], funcNames[i], 1, N, Ab, x);
    cout << endl << "Running: " << funcNames[i] << endl;
    cout << perf << " cycles" << endl;
  }

  return 0;
}
