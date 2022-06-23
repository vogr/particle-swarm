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
}

#ifdef WITH_PAPI
extern "C"
{
#include "papi.h"
}
static void handle_error(int retval)
{
  printf("PAPI error %d: %s\n", retval, PAPI_strerror(retval));
  exit(1);
}
#endif

struct perf_metrics
{
  double cycles = 0;
  double flops = 0;
  double l3_misses = 0;
};

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
  struct perf_metrics perf_test(fun_T f, std::string const &desc,
                                std::function<void()> arg_restorer,
                                Args_T... args)
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

    struct perf_metrics metrics;
#ifdef WITH_PAPI

#ifdef PERF_TESTER_OUTPUT
    std::cerr << "PAPI over " << PERF_TESTER_REP << " * " << num_runs
              << " runs.\n";
#endif

    int retval, EventSet = PAPI_NULL;

    retval = PAPI_library_init(PAPI_VER_CURRENT);
    if (retval != PAPI_VER_CURRENT && retval > 0)
    {
      fprintf(stderr, "PAPI library version mismatch!\n");
      exit(1);
    }
    else if (retval < 0)
    {
      handle_error(retval);
    }

    std::vector<std::vector<int>> event_sets{
        {PAPI_TOT_CYC, PAPI_L3_TCM},
        {PAPI_DP_OPS},
    };
    size_t n_events = 0;
    for (auto const &evset : event_sets)
    {
      n_events += evset.size();
    }

    std::vector<long long> values(n_events, 0);
    long long *dst = values.data();

    for (size_t evset_id = 0; evset_id < event_sets.size(); evset_id++)
    {
      std::vector<int> const &evset = event_sets[evset_id];

      /* Create the Event Set */
      if ((retval = PAPI_create_eventset(&EventSet)) != PAPI_OK)
        handle_error(retval);

      /* add the selected counters */
      for (auto e : evset)
      {
        std::cout << "Adding event " << e << "\n";
        if ((retval = PAPI_add_event(EventSet, e)) != PAPI_OK)
          handle_error(retval);
      }

      /* Start counting events in the Event Set */
      if ((retval = PAPI_start(EventSet)) != PAPI_OK)
        handle_error(retval);

      for (size_t j = 0; j < PERF_TESTER_REP; j++)
      {
        for (size_t i = 0; i < num_runs; ++i)
        {
          /* Reset the counting events in the Event Set */
          if ((retval = PAPI_reset(EventSet)) != PAPI_OK)
            handle_error(retval);

          f(args...);

          if ((retval = PAPI_accum(EventSet, dst)) != PAPI_OK)
            handle_error(retval);

          arg_restorer();
        }
      }

      long long null = 0;
      if ((retval = PAPI_stop(EventSet, &null)) != PAPI_OK)
        handle_error(retval);

      if ((retval = PAPI_cleanup_eventset(EventSet)) != PAPI_OK)
        handle_error(retval);

      EventSet = PAPI_NULL;

      dst += evset.size();
    }

    double scale = 1. / (PERF_TESTER_REP * num_runs);

    metrics.cycles = (double)(values[0]) * scale;
    metrics.l3_misses = (double)(values[1]) * scale;
    metrics.flops = (double)(values[2]) * scale;

#else // WITH_PAPI

#ifdef PERF_TESTER_OUTPUT
    std::cerr << "Benchmarking over " << PERF_TESTER_REP << " * " << num_runs
              << " runs.\n";
#endif

    std::list<double> cyclesList;

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
    metrics.cycles = total_cycles;
#endif // WITH_PAPI

    return metrics;
  }

  int perf_test_all_registered(std::function<void()> arg_restorer,
                               int input_size, Args_T... args)
  {
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

    for (int i = 0; i < numFuncs; i++)
    {
      std::stringstream descr;
      descr << funcNames[i] << "__" << input_size;
      struct perf_metrics metrics =
          perf_test(userFuncs[i], descr.str(), arg_restorer, args...);
      std::cout << funcNames[i] << "," << input_size << "," << metrics.cycles
                << "," << metrics.flops << "," << metrics.l3_misses
                << std::endl;
    }

    return 0;
  }
};
