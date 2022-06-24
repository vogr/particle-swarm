# Optimized OPUS

Compiling the executable:

```
CC=icc CXX=icpc make DEBUG=0
```

Compiling the shared library to run the tests

```
CC=icc CXX=icpc make DEBUG=0 PSO_SHARED=1 INC_MKL=1
```

Additionnaly:

- you can build the baseline version by passing `BASELINE=1`
- if PAPI is unavailable on your system, pass `WITH_PAPI=0` to the build command.
- you may use other compilers by specifying the `CC` and `CXX` environment variables accordingly.
