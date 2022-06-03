#include "surrogate_eval.h"
#include "math.h"
#include <immintrin.h>

#include "../helpers.h"

#define QUOTE(x) #x
#define STR(x) QUOTE(x)



double surrogate_eval(struct pso_data_constant_inertia const *pso,
                      double const *x)
{
  return surrogate_eval_3(pso, x);
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
    for (; i < pso->dimensions; i += 4)
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
    for (; i < pso->dimensions; i += 4)
    {
      //      double u0 = u[i+0], u1 = u[i+1], u2 = u[i+2], u3 = u[i+3];
      //      double x0 = x[i+0], x1 = x[i+1], x2 = x[i+2], x3 = x[i+3];
      u_vec = _mm256_loadu_pd(u + i);
      x_vec = _mm256_loadu_pd(x + i);

      v = _mm256_sub_pd(u_vec, x_vec);      // u - x
      s_acc = _mm256_fmadd_pd(v, v, s_acc); // s += v*v
    }

    // source https://stackoverflow.com/questions/49941645/get-sum-of-values-stored-in-m256d-with-sse-avx
    __m128d vlow = _mm256_castpd256_pd128(s_acc);
    __m128d vhigh = _mm256_extractf128_pd(s_acc, 1);       // high 128
    vlow = _mm_add_pd(vlow, vhigh);              // reduce down to 128

    __m128d high64 = _mm_unpackhi_pd(vlow, vlow);
    double s = _mm_cvtsd_f64(_mm_add_sd(vlow, high64)); // reduce to scalar
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
