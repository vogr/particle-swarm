#include "surrogate_eval.h"
#include "math.h"
#include <immintrin.h>

#include "linear_system_solver.h"

#include "../helpers.h"

#define QUOTE(x) #x
#define STR(x) QUOTE(x)

double surrogate_eval(struct pso_data_constant_inertia const *pso,
                      double const *x)
{
  return SURROGATE_EVAL_VERSION(pso, x);
}

double surrogate_eval_0(struct pso_data_constant_inertia const *pso,
                        double const *x)
{
  double res = 0;

  double *lambda_p = pso->lambda_p;
  // lambda_p is the concatenation (lambda_0 ... lambda_i || p_0 ... p_(d+1))
  double *lambda = lambda_p;
  double *p_coef = lambda_p + pso->x_distinct_s;

  //  printf("pso->x_distinct_s: %zu\n", pso->x_distinct_s);
  // iterate directly on x_distinct
  for (size_t k = 0; k < pso->x_distinct_s; k++)
  {
    double *u = pso->x_distinct + k * pso->dimensions;
    double d = dist(pso->dimensions, u, x);
    res += lambda[k] * d * d * d;
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += p_coef[j + 1] * x[j];
  }
  res += p_coef[0];

  return res;
}

/*
 * inlining all calculation (just for correction)
 */
double surrogate_eval_1(struct pso_data_constant_inertia const *pso,
                        double const *x)
{
  double res = 0;

  double *lambda_p = pso->lambda_p;
  // lambda_p is the concatenation (lambda_0 ... lambda_i || p_0 ... p_(d+1))
  double *lambda = lambda_p;
  double *p_coef = lambda_p + pso->x_distinct_s;

  // iterate directly on x_distinct
  for (size_t k = 0; k < pso->x_distinct_s; k++)
  {
    double *u = pso->x_distinct + k * pso->dimensions;

    double s = 0;
    for (size_t i = 0; i < pso->dimensions; i++)
    {
      double v = u[i] - x[i];
      s += v * v;
    }

    double d = sqrt(s);       // dist(pso->dimensions, u, x);
    res += lambda[k] * s * d; // replace  (sqrt(s))^3 with s*sqrt(s)
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += p_coef[j + 1] * x[j];
  }
  res += p_coef[0];

  return res;
}

/*
 * loop unrolling
 */
double surrogate_eval_2(struct pso_data_constant_inertia const *pso,
                        double const *x)
{
  double res = 0;

  double *lambda_p = pso->lambda_p;
  // lambda_p is the concatenation (lambda_0 ... lambda_i || p_0 ... p_(d+1))
  double *lambda = lambda_p;
  double *p_coef = lambda_p + pso->x_distinct_s;

  // iterate directly on x_distinct
  for (size_t k = 0; k < pso->x_distinct_s; k++)
  {
    double *u = pso->x_distinct + k * pso->dimensions;

    double s0 = 0, s1 = 0, s2 = 0, s3 = 0;
    size_t i = 0;
    for (; i +3 < pso->dimensions; i += 4)
    {
      double u0 = u[i + 0], u1 = u[i + 1], u2 = u[i + 2], u3 = u[i + 3];
      double x0 = x[i + 0], x1 = x[i + 1], x2 = x[i + 2], x3 = x[i + 3];

      double v0 = u0 - x0;
      double v1 = u1 - x1;
      double v2 = u2 - x2;
      double v3 = u3 - x3;

      s0 += v0 * v0;
      s1 += v1 * v1;
      s2 += v2 * v2;
      s3 += v3 * v3;
    }
    for (; i < pso->dimensions; i++)
    {
      double v = u[i] - x[i];
      s0 += v * v;
    }

    double s = s0 + s1 + s2 + s3;
    double d = sqrt(s);

    res += lambda[k] * s * d;
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += p_coef[j + 1] * x[j];
  }
  res += p_coef[0];

  return res;
}

/*
 * vectorize inner loop
 * (further unrolling required)
 */
double surrogate_eval_3(struct pso_data_constant_inertia const *pso,
                        double const *x)
{
  double res = 0;

  double *lambda_p = pso->lambda_p;
  // lambda_p is the concatenation (lambda_0 ... lambda_i || p_0 ... p_(d+1))
  double *lambda = lambda_p;
  double *p_coef = lambda_p + pso->x_distinct_s;

  // iterate directly on x_distinct
  for (size_t k = 0; k < pso->x_distinct_s; k++)
  {
    double *u = pso->x_distinct + k * pso->dimensions;

    double s0 = 0, s1 = 0, s2 = 0, s3 = 0;
    size_t i = 0;

    __m256d u_vec, x_vec, v, s_acc;
    s_acc = _mm256_set1_pd(0);
    for (; i +3 < pso->dimensions; i += 4)
    {
      //      double u0 = u[i+0], u1 = u[i+1], u2 = u[i+2], u3 = u[i+3];
      //      double x0 = x[i+0], x1 = x[i+1], x2 = x[i+2], x3 = x[i+3];
      u_vec = _mm256_loadu_pd(u + i);
      x_vec = _mm256_loadu_pd(x + i);

      v = _mm256_sub_pd(u_vec, x_vec);      // u - x
      s_acc = _mm256_fmadd_pd(v, v, s_acc); // s += v*v
    }

    // source
    // https://stackoverflow.com/questions/49941645/get-sum-of-values-stored-in-m256d-with-sse-avx
    __m128d vlow = _mm256_castpd256_pd128(s_acc);
    __m128d vhigh = _mm256_extractf128_pd(s_acc, 1); // high 128
    vlow = _mm_add_pd(vlow, vhigh);                  // reduce down to 128

    __m128d high64 = _mm_unpackhi_pd(vlow, vlow);
    double s = _mm_cvtsd_f64(_mm_add_sd(vlow, high64)); // reduce to scalar

    for (; i < pso->dimensions; i++)
    {
      double v = u[i] - x[i];
      s += v * v;
    }

    double d = sqrt(s);

    res += lambda[k] * s * d;
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += p_coef[j + 1] * x[j];
  }
  res += p_coef[0];

  return res;
}

/*
 * vectorize outer loop (2x) + inner loop (4x)
 */
double surrogate_eval_4(struct pso_data_constant_inertia const *pso,
                        double const *x_ptr)
{
  size_t dim = pso->dimensions;

  double res = 0;

  double *lambda_p = pso->lambda_p;
  // lambda_p is the concatenation (lambda_0 ... lambda_i || p_0 ... p_(d+1))
  double *lambda = lambda_p;
  double *p_coef = lambda_p + pso->x_distinct_s;

  // iterate directly on x_distinct
  size_t k = 0;
  for (; k + 1 < pso->x_distinct_s ; k += 2)
  {
    double *u0_ptr = pso->x_distinct + k * dim;
    double *u1_ptr = pso->x_distinct + (k + 1) * dim;
    //    double *u2 = pso->x_distinct + (k+2)*dim;
    //    double *u3 = pso->x_distinct + (k+3)*dim;

    __m256d u0, u1, v0, v1, s0, s1;
    __m256d x;
    s0 = _mm256_set1_pd(0);
    s1 = _mm256_set1_pd(0);

    size_t i = 0;
    for (; i +3 < pso->dimensions; i += 4)
    {
      u0 = _mm256_loadu_pd(u0_ptr + i);
      u1 = _mm256_loadu_pd(u1_ptr + i);
      x = _mm256_loadu_pd(x_ptr + i);

      v0 = _mm256_sub_pd(u0, x); // u - x_ptr
      v1 = _mm256_sub_pd(u1, x);
      s0 = _mm256_fmadd_pd(v0, v0, s0); // s += v*v
      s1 = _mm256_fmadd_pd(v1, v1, s1);
    }

    // source for horizontal add
    // https://stackoverflow.com/questions/49941645/get-sum-of-values-stored-in-m256d-with-sse-avx
    __m128d vlow = _mm256_castpd256_pd128(s0);
    __m128d vhigh = _mm256_extractf128_pd(s0, 1); // high 128
    vlow = _mm_add_pd(vlow, vhigh);               // reduce down to 128
    __m128d high64 = _mm_unpackhi_pd(vlow, vlow);
    double s0_d = _mm_cvtsd_f64(_mm_add_sd(vlow, high64)); // reduce to scalar

    vlow = _mm256_castpd256_pd128(s1);
    vhigh = _mm256_extractf128_pd(s1, 1); // high 128
    vlow = _mm_add_pd(vlow, vhigh);       // reduce down to 128
    high64 = _mm_unpackhi_pd(vlow, vlow);
    double s1_d = _mm_cvtsd_f64(_mm_add_sd(vlow, high64)); // reduce to scalar

    for (; i < pso->dimensions; i++)
    {
      double v0_d = u0_ptr[i] - x_ptr[i];
      double v1_d = u1_ptr[i] - x_ptr[i];
      s0_d += v0_d * v0_d;
      s1_d += v1_d * v1_d;
    }

    double d0 = sqrt(s0_d);
    double d1 = sqrt(s1_d);

    res += lambda[k] * s0_d * d0;
    res += lambda[k + 1] * s1_d * d1;
  }

  for (; k < pso->x_distinct_s; k++) // roll up
  {
    double *u = pso->x_distinct + k * pso->dimensions;

    double s0 = 0, s1 = 0, s2 = 0, s3 = 0;
    size_t i = 0;

    __m256d u_vec, x_vec, v, s_acc;
    s_acc = _mm256_set1_pd(0);
    for (; i +3 < pso->dimensions; i += 4)
    {
      //      double u0 = u[i+0], u1 = u[i+1], u2 = u[i+2], u3 = u[i+3];
      //      double x0 = x[i+0], x1 = x[i+1], x2 = x[i+2], x3 = x[i+3];
      u_vec = _mm256_loadu_pd(u + i);
      x_vec = _mm256_loadu_pd(x_ptr + i);

      v = _mm256_sub_pd(u_vec, x_vec);      // u - x
      s_acc = _mm256_fmadd_pd(v, v, s_acc); // s += v*v
    }

    // source
    // https://stackoverflow.com/questions/49941645/get-sum-of-values-stored-in-m256d-with-sse-avx
    __m128d vlow = _mm256_castpd256_pd128(s_acc);
    __m128d vhigh = _mm256_extractf128_pd(s_acc, 1); // high 128
    vlow = _mm_add_pd(vlow, vhigh);                  // reduce down to 128

    __m128d high64 = _mm_unpackhi_pd(vlow, vlow);
    double s = _mm_cvtsd_f64(_mm_add_sd(vlow, high64)); // reduce to scalar

    for (; i < pso->dimensions; i++)
    {
      double v = u[i] - x_ptr[i];
      s += v * v;
    }

    double d = sqrt(s);

    res += lambda[k] * s * d;
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += p_coef[j + 1] * x_ptr[j];
  }
  res += p_coef[0];

  return res;
}

/*
 * use hadd sum inside the avx2 vectors
 */
double surrogate_eval_5(struct pso_data_constant_inertia const *pso,
                        double const *x_ptr)
{
  size_t dim = pso->dimensions;

  double *lambda_p = pso->lambda_p;
#if LINEAR_SYSTEM_SOLVER_USED == BLOCK_TRI_SOLVER
  // lambda_p is the concatenation (p_0 ... p_(d+1) || lambda_0 ... lambda_i)
  double *lambda = lambda_p + pso->dimensions + 1;
  double *p_coef = lambda_p;
#else
  // lambda_p is the concatenation (lambda_0 ... lambda_i || p_0 ... p_(d+1))
  double *lambda = lambda_p;
  double *p_coef = lambda_p + pso->x_distinct_s;
#endif

  // iterate directly on x_distinct
  size_t k = 0;

  __m128d res2 = _mm_set1_pd(0);
  for (; k < pso->x_distinct_s - 1; k += 2)
  {
    double *u0_ptr = pso->x_distinct + k * dim;
    double *u1_ptr = pso->x_distinct + (k + 1) * dim;
    //    double *u2 = pso->x_distinct + (k+2)*dim;
    //    double *u3 = pso->x_distinct + (k+3)*dim;

    __m256d s0 = _mm256_set1_pd(0);
    __m256d s1 = _mm256_set1_pd(0);

    size_t i = 0;
    for (; i +3 < pso->dimensions; i += 4)
    {
      __m256d u0 = _mm256_loadu_pd(u0_ptr + i);
      __m256d u1 = _mm256_loadu_pd(u1_ptr + i);
      __m256d x = _mm256_loadu_pd(x_ptr + i);

      __m256d v0 = _mm256_sub_pd(u0, x); // u - x_ptr
      __m256d v1 = _mm256_sub_pd(u1, x);
      s0 = _mm256_fmadd_pd(v0, v0, s0); // s += v*v
      s1 = _mm256_fmadd_pd(v1, v1, s1);
    }

    // s0 = a1 a2 a3 a4
    // s1 = b1 b2 b3 b4
    __m256d t1 = _mm256_hadd_pd(s0, s1);
    // t1 = (a1 + a2) (b1 + b2) (a3 + a4) (b3 + b4)

    __m128d tlow = _mm256_castpd256_pd128(t1);
    __m128d thigh = _mm256_extractf128_pd(t1, 1); // high 128
    __m128d d2 = _mm_add_pd(tlow, thigh);
    // t2 = (a1 + .. + a4) (b1 + .. + b4)

    for (; i < pso->dimensions; i++)
    {
      __m128d uu = _mm_load1_pd(&u0_ptr[i]);
      __m128d uv = _mm_loadh_pd(uu, &u1_ptr[i]);
      __m128d xi = _mm_load1_pd(&x_ptr[i]);
      __m128d diff = _mm_sub_pd(uv, xi);
      d2 = _mm_fmadd_pd(diff, diff, d2);
    }

    __m128d d = _mm_sqrt_pd(d2);
    __m128d d3 = _mm_mul_pd(d, d2);

    __m128d lambd = _mm_loadu_pd(&lambda[k]);

    __m128d lambd_d3 = _mm_mul_pd(lambd, d3);

    res2 = _mm_add_pd(res2, lambd_d3);
  }

  double res = res2[0] + res2[1];
  for (; k < pso->x_distinct_s; k++) // roll up
  {
    double *u = pso->x_distinct + k * pso->dimensions;

    double s0 = 0, s1 = 0, s2 = 0, s3 = 0;
    size_t i = 0;

    __m256d u_vec, x_vec, v, s_acc;
    s_acc = _mm256_set1_pd(0);
    for (; i +3 < pso->dimensions; i += 4)
    {
      //      double u0 = u[i+0], u1 = u[i+1], u2 = u[i+2], u3 = u[i+3];
      //      double x0 = x[i+0], x1 = x[i+1], x2 = x[i+2], x3 = x[i+3];
      u_vec = _mm256_loadu_pd(u + i);
      x_vec = _mm256_loadu_pd(x_ptr + i);

      v = _mm256_sub_pd(u_vec, x_vec);      // u - x
      s_acc = _mm256_fmadd_pd(v, v, s_acc); // s += v*v
    }

    // source
    // https://stackoverflow.com/questions/49941645/get-sum-of-values-stored-in-m256d-with-sse-avx
    __m128d vlow = _mm256_castpd256_pd128(s_acc);
    __m128d vhigh = _mm256_extractf128_pd(s_acc, 1); // high 128
    vlow = _mm_add_pd(vlow, vhigh);                  // reduce down to 128

    __m128d high64 = _mm_unpackhi_pd(vlow, vlow);
    double s = _mm_cvtsd_f64(_mm_add_sd(vlow, high64)); // reduce to scalar

    for (; i < pso->dimensions; i++)
    {
      double v = u[i] - x_ptr[i];
      s += v * v;
    }

    double d = sqrt(s);

    res += lambda[k] * s * d;
  }

  for (int j = 0; j < pso->dimensions; j++)
  {
    res += p_coef[j + 1] * x_ptr[j];
  }
  res += p_coef[0];

  return res;
}
