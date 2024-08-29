# Particle swarm fast implementation

See [report.pdf](./report.pdf) for the full description and analysis of our implementation.

This project is based on the method described in the article [Particle swarm with radial basis function surrogates for expensive black-box optimization](https://acl.inf.ethz.ch/teaching/fastcode/2022/project/project-ideas/particle-swarm.pdf).

## Code Formatting 

Running `git config --local core.hooksPath .githooks` will enable the githooks which use Clang Format to cleanup modified files. Please opt-in.

# Correctness / Performance

In order to test the code, for both performance and correctness, we have a system set in place to modularly test each component. To build the necessary shared library do the following:

```bash
$ cd opus
$ DEBUG=1 PSO_SHARED=1 make
```

This will make a shared library `pso.so` (`libpso.dylib` on MacOS) which you should put somewhere on your `LD_LIBRARY` (`DYLD_LIBRARY_PATH` on MacOS) such that Julia can find it. 
In order to run the suite, do the following:

```bash
$ cd /tests
$ julia
julia> ]
(tests) pkg> activate .
<backspace> # this means hit the backspace/delete key to leave Pkg mode
julia> include("src/tests.jl") # this will run the enabled tests, Gavin plans on improving this interface later
```

Alternatively, a better approach is to run the tests directly through the command line with `julia src/tests.jl`, which accepts a combination of the following patterns.

``` bash
julia src/tests PERF
julia src/tests AUTO <path to libs>
julia src/tests TEST
```

> :warning: the current TEST option is out-of-date. It only tests the LU Solver currently for simplicity as no more GE and TS changes are being made.

## Autotuning

To run the autotuning script you must first install Racket and the DSL `rash`. Then run `cd scripts && ./autotune.rkt`.
This will build shared libraries as needed and then you can test them with `julia src/tests AUTO ../lib`

:beers:

Gavin Gray, Valentin Ogier, Xavier Servot, York Schlabrendorf

