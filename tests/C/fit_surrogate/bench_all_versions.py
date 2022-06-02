#!/usr/bin/env python3

from pathlib import Path
import subprocess
import shutil
import os
import sys

CONFIGURATIONS = [
(0, "-DFIT_SURROGATE_VERSION=fit_surrogate_0 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_0 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0"),
(1, "-DFIT_SURROGATE_VERSION=fit_surrogate_1 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_1 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0"),
(2, "-DFIT_SURROGATE_VERSION=fit_surrogate_2 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_2 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0"),
(3, "-DFIT_SURROGATE_VERSION=fit_surrogate_3 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_3 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0"),
(4, "-DFIT_SURROGATE_VERSION=fit_surrogate_4 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_4 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0"),
(5, "-DFIT_SURROGATE_VERSION=fit_surrogate_5 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_5 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_0"),
(6, "-DFIT_SURROGATE_VERSION=fit_surrogate_6 -DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_6 -DCHECK_IF_DISTINCT_VERSION=check_if_distinct_1")
]

def main(argv):
    curdir = Path(".").resolve()
    opus_dir = Path("../../../opus").resolve()
    libdir = curdir / "libs"
    libdir.mkdir(exist_ok=True)
    
    rebuild = (len(argv) < 2) or (int(argv[1]) != 0)

    if rebuild:
        for i, config in CONFIGURATIONS:

            print(f"\n********\nBUILDING CONFIG {i}\n********\n")
            subprocess.run(["make", "clean"], cwd=opus_dir)

            env = {"CPPFLAGS": config}
            env["PATH"] = os.environ["PATH"]

            subprocess.run(["uname", "-s"], env=env, cwd=opus_dir)
            subprocess.run(["pwd"], env=env, cwd=opus_dir)
            subprocess.run(["make", "DEBUG=0", "PSO_SHARED=1"], env=env, cwd=opus_dir)

            libpso_src = opus_dir / "libpso.so"
            libpso_destdir = libdir / "config{}".format(i)
            libpso_destdir.mkdir(exist_ok=True)

            shutil.copy(libpso_src, libpso_destdir)

    
    subprocess.run(["make"], cwd=curdir)

    for i, config in CONFIGURATIONS:
        print(f"\n********\nBENCHMARKING CONFIG {i}:\n{config}\n********\n")
        libpso_destdir = libdir / "config{}".format(i)
        env = {"LD_LIBRARY_PATH": str(libpso_destdir)}
        env["PATH"] = os.environ["PATH"]
        subprocess.run(["./test"], env=env, cwd=curdir)




if __name__ == "__main__":
    main(sys.argv)