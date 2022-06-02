#!/usr/bin/env python3

import argparse
from pathlib import Path
import subprocess
import shutil
import os
import sys


CONFIGURATIONS = {
    0: "-DFIT_SURROGATE_VERSION=fit_surrogate_0 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_0 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
    1: "-DFIT_SURROGATE_VERSION=fit_surrogate_1 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_1 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
    2: "-DFIT_SURROGATE_VERSION=fit_surrogate_2 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_2 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
    3: "-DFIT_SURROGATE_VERSION=fit_surrogate_3 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_3 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
    4: "-DFIT_SURROGATE_VERSION=fit_surrogate_4 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_4 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
    5: "-DFIT_SURROGATE_VERSION=fit_surrogate_5 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_5 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0",
    6: "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1"
}



parser = argparse.ArgumentParser(description='Benchmark under several compile-time configurations.')
parser.add_argument('config_nbs', metavar='N', type=int, nargs='*',
                    help='the configs to build/benchmark/profile [defaults to all]')
parser.add_argument('--build', action="store_true")
parser.add_argument('--benchmark', action="store_true")
parser.add_argument('--profile', action="store_true")


def main(argv):
    curdir = Path(".").resolve()
    opus_dir = Path("../../../opus").resolve()
    libdir = curdir / "libs"
    libdir.mkdir(exist_ok=True)

    build_env = {"PATH": os.environ["PATH"], "CFLAGS": "-g -fno-omit-frame-pointer", "CXXFLAGS": "-g -fno-omit-frame-pointer"}

    args = parser.parse_args(argv[1:])

    if len(args.config_nbs) == 0:
        args.config_nbs = CONFIGURATIONS.keys()

    if args.build:
        for i in args.config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nBUILDING CONFIG {i}\n********\n")
            subprocess.run(["make", "clean"], cwd=opus_dir)

            env = {**build_env, "CPPFLAGS": config}
            subprocess.run(["make", "DEBUG=0", "PSO_SHARED=1"], env=env, cwd=opus_dir)

            libpso_src = opus_dir / "libpso.so"
            libpso_destdir = libdir / "config{}".format(i)
            libpso_destdir.mkdir(exist_ok=True)

            shutil.copy(libpso_src, libpso_destdir)

    

    if args.benchmark:
        subprocess.run(["make"], cwd=curdir, env=build_env)
        for i in args.config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nBENCHMARKING CONFIG {i}:\n{config}\n********\n")
            libpso_destdir = libdir / "config{}".format(i)
            env = {"PATH": os.environ["PATH"], "LD_LIBRARY_PATH": str(libpso_destdir)}
            subprocess.run(["./test"], env=env, cwd=curdir)

    flame_dir = curdir / "flamegraphs"
    flame_dir.mkdir(exist_ok=True)
    if args.profile:
        subprocess.run(["make"], cwd=curdir, env=build_env)
        for i in args.config_nbs:
            config = CONFIGURATIONS[i]
            print(f"\n********\nPROFILE CONFIG {i}:\n{config}\n********\n")
            libpso_destdir = libdir / "config{}".format(i)
            env = {"PATH": os.environ["PATH"], "LD_LIBRARY_PATH": str(libpso_destdir)}
            subprocess.run(["perf", "record", "--call-graph", "dwarf", "-F", "99", "./test", "--no-bench"], env=env, cwd=curdir)

            this_config_perf_folded = flame_dir / "out_{i}.perf-folded"
            this_config_fg = flame_dir / "flamegraph_{i}.svg"

            perf_script = subprocess.run(["perf", "script"], capture_output=True, env=env, cwd=curdir)
            stackcollapse = subprocess.run(["stackcollapse-perf.pl"], capture_output=True, env=env, cwd=curdir, input=perf_script.stdout)
            
            this_config_perf_folded.write_bytes(stackcollapse.stdout)
            
            flamegraph = subprocess.run(["flamegraph.pl", str(this_config_perf_folded)], capture_output=True, env=env, cwd=curdir)
            this_config_fg.write_bytes(flamegraph.stdout)

if __name__ == "__main__":
    main(sys.argv)
