#!/usr/bin/env python3

from pathlib import Path
import subprocess
import shutil
import os
import sys

CONFIGURATIONS = [
(i, "-DFIT_SURROGATE_VERSION=fit_surrogate_{} \
-DFIT_SURROGATE_PREALLOC_VERSION=prealloc_fit_surrogate_{}".format(i,i))
for i in range(0,6)
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