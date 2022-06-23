#pragma once

#ifdef PAPI_WHOLE_SYSTEM

#include "papi.h"
#define PAPI_START(x) PAPI_hl_region_begin((x))
#define PAPI_STOP(x) PAPI_hl_region_end((x))

#else

#define PAPI_START(x)                                                          \
  do                                                                           \
  {                                                                            \
  } while (0)
#define PAPI_STOP(x)                                                           \
  do                                                                           \
  {                                                                            \
  } while (0)

#endif