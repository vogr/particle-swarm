#pragma once

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
#include <functional>
#include <iostream>
#include <list>
#include <sstream>
#include <string>
#include <vector>

extern "C"
{
#include "tsc_x86.h"

#ifdef WITH_PAPI
#include "papi.h"
#endif
}

// #define PERF_TESTER_OUTPUT
//#define PERF_TESTER_NR 32
#define PERF_TESTER_CYCLES_REQUIRED 1e6
#define PERF_TESTER_REP 20
//#define PERF_TESTER_EPS (1e-3)

// destructuring function pointer template type
// into return type and argument type:
// see https://devblogs.microsoft.com/oldnewthing/20200713-00/?p=103978

// The PerformanceTester template parametrized by a function
// pointer. To allow explicit type parametrization, needs an
// empty primary template.
template <typename F> class PerformanceTester;

// Partial specialization specialized for function pointers.
template <typename Ret_T, typename... Args_T>
class PerformanceTester<Ret_T (*)(Args_T...)>
{
  // the signature of the functions(s) we want to benchmark
  typedef Ret_T (*fun_T)(Args_T...);

private:
  std::vector<fun_T> userFuncs;
  std::vector<std::string> funcNames;
  int numFuncs = 0;

public:
  /*
   * Registers a user function to be tested by the driver program. Registers a
   * string description of the function as well
   */
  void add_function(fun_T f, std::string const &name, int flop)
  {
    userFuncs.push_back(f);
    funcNames.emplace_back(name);
    numFuncs++;
  };

  /*
   * Checks the given function for validity (XXX does it?) (RE: no, it doesn't).
   * If valid, then computes and reports and returns the number of cycles
   * required per iteration
   */
  double perf_test(fun_T f, std::string const &desc,
                   std::function<void()> arg_restorer, Args_T... args)
  {
    double cycles = 0.;
    long num_runs = 2;
    double multiplier = 1;
    myInt64 start, end;

    // Warm-up phase: we determine a number of executions that allows
    // the code to be executed for at least CYCLES_REQUIRED cycles.
    // This helps excluding timing overhead when measuring small runtimes.
    do
    {
      num_runs = num_runs * multiplier;
      start = start_tsc();
      for (size_t i = 0; i < num_runs; i++)
      {
        f(args...);
      }
      end = stop_tsc(start);

      cycles = (double)end;

      arg_restorer();

      multiplier = (PERF_TESTER_CYCLES_REQUIRED) / (cycles);

    } while (multiplier > 2);

    std::list<double> cyclesList;

#ifdef PERF_TESTER_OUTPUT
    std::cerr << "Benchmarking over " << PERF_TESTER_REP << " * " << num_runs
              << " runs.\n";
#endif

    // Actual performance measurements repeated REP times.
    // We simply store all results and compute medians during post-processing.
    double total_cycles = 0;
    for (size_t j = 0; j < PERF_TESTER_REP; j++)
    {
      for (size_t i = 0; i < num_runs; ++i)
      {
        start = start_tsc();
        f(args...);
        end = stop_tsc(start);
        cycles = ((double)end);
        total_cycles += cycles;
        cyclesList.push_back(cycles); // XXX why have this

        arg_restorer();
      }
    }
    total_cycles /= (PERF_TESTER_REP * num_runs);
    cycles = total_cycles;

#ifdef WITH_PAPI

#ifdef PERF_TESTER_OUTPUT
    std::cerr << "PAPI over " << PERF_TESTER_REP << " * " << num_runs
              << " runs.\n";
#endif

    // Measure again, this time with PAPI
    for (size_t j = 0; j < PERF_TESTER_REP; j++)
    {
      for (size_t i = 0; i < num_runs; ++i)
      {
        PAPI_hl_region_begin(desc.data());
        f(args...);
        PAPI_hl_region_end(desc.data());

        arg_restorer();
      }
    }
#endif

    return cycles;
  }

  int perf_test_all_registered(std::function<void()> arg_restorer,
                               int input_size, Args_T... args)
  {
    // std::cerr << "Starting performance tests.";
    double perf;
    int i;

    if (numFuncs == 0)
    {
      std::cerr << std::endl;
      std::cerr << "No functions registered - nothing for driver to do"
                << std::endl;
      std::cerr << "Register functions by calling register_func(f, name)"
                << std::endl;
      std::cerr << "in register_funcs()" << std::endl;
      return -1;
    }

#ifdef PERF_TESTER_OUTPUT
    std::cerr << " " << numFuncs << " functions registered." << std::endl;
#endif

    for (i = 0; i < numFuncs; i++)
    {
      std::stringstream descr;
      descr << funcNames[i] << "__" << input_size;
      perf = perf_test(userFuncs[i], descr.str(), arg_restorer, args...);
      std::cout << funcNames[i] << "," << input_size << "," << perf
                << std::endl;
    }

    return 0;
  }
};
