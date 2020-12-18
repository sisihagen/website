#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# delete js in home and about

# html clean and minify for all sites
# german site
if [[ -d "$build/$sde" ]]; then
  # delete the static folder
  clean_dir "$build/$sde/static"

  if [[ -d "$dest/$de/htdocs" ]]; then
    # clean js
    deletejs "$build/$sde/index.html"
    deletejs "$build/$sde/about/index.html"

    # copy html
    html "$build/$sde/" "$dest/$de/htdocs/"
  fi
fi

# english site
if [[ -d "$build/$sen" ]]; then
  # delete the static folder
  clean_dir "$build/$sen/static"

  if [[ -d "$dest/$en/htdocs" ]]; then
    # clean js
    deletejs "$build/$sen/index.html"
    deletejs "$build/$sen/about/index.html"

    # copy html
    html "$build/$sen/" "$dest/$en/htdocs/"
  fi
fi

# french site
if [[ -d "$build/$sfr" ]]; then
  # delete the static folder
  clean_dir "$build/$sfr/static"

  if [[ -d "$dest/$fr/htdocs" ]]; then
    # clean js
    deletejs "$build/$sfr/index.html"
    deletejs "$build/$sfr/about/index.html"

    # copy html
    html "$build/$sfr/" "$dest/$fr/htdocs/"
  fi
fi

# russian site
if [[ -d "$build/$sru" ]]; then
  # delete the static folder
  clean_dir "$build/$sru/static"

  if [[ -d "$dest/$ru/htdocs" ]]; then
    # clean js
    deletejs "$build/$sru/index.html"
    deletejs "$build/$sru/about/index.html"

    # copy html
    html "$build/$sru/" "$dest/$ru/htdocs/"
  fi
fi
