#include "helpers.hpp"

#include <cstdlib>

double rand_between(double a, double b)
{
    // see http://c-faq.com/lib/randrange.html
    return a + (double)rand() / ((double)RAND_MAX / (b - a));
}


double clamp(double v, double lo, double hi)
{
    if (v < lo)
    {
        return lo;
    }
    else if (v > hi)
    {
        return hi;
    }
    else
    {
        return v;
    }
}