#pragma once 

#include "stdlib.h"

enum range_scheme_t_ { cubic_interpolation, linear };
typedef enum range_scheme_t_ range_scheme_t;

void run_perf_tests_range_cubic_interpolation(size_t start, size_t step, size_t stop, range_scheme_t scheme);
