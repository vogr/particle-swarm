#!/usr/bin/env python3

import argparse
from pathlib import Path
import subprocess
import shutil
import os
import sys


CONFIGURATIONS = {}


CONFIGURATIONS[0] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_0"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_0 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_0 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
}
CONFIGURATIONS[1] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_1"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_1 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_1 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
}
CONFIGURATIONS[2] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_2"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_2 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_2 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
}

CONFIGURATIONS[3] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_3"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_3 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_3 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
}
CONFIGURATIONS[4] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_4"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_4 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_4 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
}
CONFIGURATIONS[5] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_5"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_5 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_5 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
}
CONFIGURATIONS[6] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_6_GE"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1 -DLINEAR_SYSTEM_SOLVER_USED=1",
}



CONFIGURATIONS[8] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_6_LU_1"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1 -DLINEAR_SYSTEM_SOLVER_USED=2 -DLU_SOLVE_VERSION=lu_solve_1",
}
CONFIGURATIONS[9] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_6_LU_2"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1 -DLINEAR_SYSTEM_SOLVER_USED=2 -DLU_SOLVE_VERSION=lu_solve_2",
}
CONFIGURATIONS[10] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_6_LU_5"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1 -DLINEAR_SYSTEM_SOLVER_USED=2 -DLU_SOLVE_VERSION=lu_solve_5",
}
CONFIGURATIONS[11] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_6_LU_6"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1 -DLINEAR_SYSTEM_SOLVER_USED=2 -DLU_SOLVE_VERSION=lu_solve_6",
}




CONFIGURATIONS[20] = {
        "bench-flags": ["--bench-fit-surrogate", "fit_surrogate_6_TRI"],
        "CPPFLAGS": "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1 -DLINEAR_SYSTEM_SOLVER_USED=3",
}



CONFIGURATIONS[50] = {
        "bench-flags": ["--bench-surrogate-eval", "surrogate_eval_0"],
        "CPPFLAGS": "-DSURROGATE_EVAL_VERSION=surrogate_eval_0",
}
CONFIGURATIONS[51] = {
        "bench-flags": ["--bench-surrogate-eval", "surrogate_eval_1"],
        "CPPFLAGS": "-DSURROGATE_EVAL_VERSION=surrogate_eval_1",
}
CONFIGURATIONS[52] = {
        "bench-flags": ["--bench-surrogate-eval", "surrogate_eval_2"],
        "CPPFLAGS": "-DSURROGATE_EVAL_VERSION=surrogate_eval_2",
}
CONFIGURATIONS[53] = {
        "bench-flags": ["--bench-surrogate-eval", "surrogate_eval_3"],
        "CPPFLAGS": "-DSURROGATE_EVAL_VERSION=surrogate_eval_3",
}
CONFIGURATIONS[54] = {
        "bench-flags": ["--bench-surrogate-eval", "surrogate_eval_4"],
        "CPPFLAGS": "-DSURROGATE_EVAL_VERSION=surrogate_eval_4",
}
CONFIGURATIONS[55] = {
        "bench-flags": ["--bench-surrogate-eval", "surrogate_eval_5"],
        "CPPFLAGS": "-DSURROGATE_EVAL_VERSION=surrogate_eval_5",
}

parser = argparse.ArgumentParser(description='Benchmark under several compile-time configurations.')
parser.add_argument('config_nbs', metavar='N', type=int, nargs='*',
                    help='the configs to build/benchmark/profile [defaults to all]')
parser.add_argument('--build', action="store_true")
parser.add_argument('--benchmark', action="store_true")
parser.add_argument('--profile', action="store_true")
parser.add_argument('--test', action="store_true")


def main(argv):
    curdir = Path(".").resolve()
    opus_dir = Path("../../../opus").resolve()
    libdir = curdir / "libs"
    libdir.mkdir(exist_ok=True)

    build_env = {"PATH": os.environ["PATH"], "CFLAGS": "-g -fno-omit-frame-pointer", "CXXFLAGS": "-g -fno-omit-frame-pointer"}

    args = parser.parse_args(argv[1:])

    config_nbs = []
    if len(args.config_nbs) > 0:
        config_nbs = args.config_nbs
    else:
        config_nbs = CONFIGURATIONS.keys()

    if args.build:
        for i in config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nBUILDING CONFIG {i}\n********\n")
            subprocess.run(["make", "clean"], cwd=opus_dir)

            env = {**build_env, "CPPFLAGS": config["CPPFLAGS"]}
            subprocess.run(["make", "DEBUG=0", "PSO_SHARED=1"], env=env, cwd=opus_dir)

            libpso_src = opus_dir / "libpso.so"
            libpso_destdir = libdir / "config{}".format(i)
            libpso_destdir.mkdir(exist_ok=True)

            shutil.copy(libpso_src, libpso_destdir)

    if args.test:
        subprocess.run(["make"], cwd=curdir, env=build_env)
        for i in config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nTESTING CONFIG {i}:\n{config}\n********\n")
            libpso_destdir = libdir / "config{}".format(i)
            env = {"PATH": os.environ["PATH"], "LD_LIBRARY_PATH": str(libpso_destdir)}
            subprocess.run(["./test", "--print"], env=env, cwd=curdir)

    if args.benchmark:
        subprocess.run(["make"], cwd=curdir, env=build_env)
        for i in config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nBENCHMARKING CONFIG {i}:\n{config}\n********\n")
            libpso_destdir = libdir / "config{}".format(i)
            env = {"PATH": os.environ["PATH"], "LD_LIBRARY_PATH": str(libpso_destdir)}
            subprocess.run(["./test"] + config["bench-flags"], env=env, cwd=curdir)

    flame_dir = curdir / "flamegraphs"
    flame_dir.mkdir(exist_ok=True)
    if args.profile:
        subprocess.run(["make"], cwd=curdir, env=build_env)
        for i in config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nPROFILE CONFIG {i}:\n{config}\n********\n")
            libpso_destdir = libdir / "config{}".format(i)
            env = {"PATH": os.environ["PATH"], "LD_LIBRARY_PATH": str(libpso_destdir)}
            subprocess.run(["perf", "record", "--call-graph", "dwarf", "-F", "99", "./test"], env=env, cwd=curdir)

            this_config_perf_folded = flame_dir / f"out_{i}.perf-folded"
            this_config_fg = flame_dir / f"flamegraph_{i}.svg"

            perf_script = subprocess.run(["perf", "script"], capture_output=True, env=env, cwd=curdir)
            stackcollapse = subprocess.run(["stackcollapse-perf.pl"], capture_output=True, env=env, cwd=curdir, input=perf_script.stdout)
            
            this_config_perf_folded.write_bytes(stackcollapse.stdout)
            
            flamegraph = subprocess.run(["flamegraph.pl", str(this_config_perf_folded)], capture_output=True, env=env, cwd=curdir)
            this_config_fg.write_bytes(flamegraph.stdout)

if __name__ == "__main__":
    main(sys.argv)
