#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# html clean and minify for all sites
# german site
if [[ -d "$build/$sde" ]]; then
  # delete the static folder
  clean_dir "$build/$sde/static"

  if [[ -d "$dest/$de/htdocs" ]]; then
    html "$build/$sde/" "$dest/$de/htdocs/"
  fi
fi

# english site
if [[ -d "$build/$sen" ]]; then
  # delete the static folder
  clean_dir "$build/$sen/static"

  if [[ -d "$dest/$en/htdocs" ]]; then
    html "$build/$sen/" "$dest/$en/htdocs/"
  fi
fi

# french site
if [[ -d "$build/$sfr" ]]; then
  # delete the static folder
  clean_dir "$build/$sfr/static"

  if [[ -d "$dest/$fr/htdocs" ]]; then
    html "$build/$sfr/" "$dest/$fr/htdocs/"
  fi
fi

# russian site
if [[ -d "$build/$sru" ]]; then
  # delete the static folder
  clean_dir "$build/$sru/static"

  if [[ -d "$dest/$ru/htdocs" ]]; then
    html "$build/$sru/" "$dest/$ru/htdocs/"
  fi
fi
