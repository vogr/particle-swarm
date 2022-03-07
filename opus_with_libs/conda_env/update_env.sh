#!/usr/bin/env bash
set -u

# Create the Conda environment `asl-opus`,
# where all the required libraries will be installed.

cd "$(dirname "$0")" &&
conda env update --name "asl-opus" --file "./conda_env.yml"
