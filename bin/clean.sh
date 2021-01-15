#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh
source ./bin/function.sh

# clean dest folders
if [[ -d "./public" ]]; then
  clean_dir "$build"
  clean_dir "$pi"
  clean_dir "$dest/$de $dest/$en $dest/$fr $dest/$ru"
fi
