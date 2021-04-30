#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# html clean and minify for all sites
# german site
if [[ -d "$build/$sde" ]]; then
  if [[ -d "$dest/$de/htdocs" ]]; then
    # delete js in home and about
    deletejs "$build/$sde/index.html"
    deletejs "$build/$sde/about/index.html"

    # copy html
    cd "$build/$sde/"
    html "$dest/$de/htdocs/"
  fi

  # copy robots txt
  if [[ -f "$build/$sde/robots.txt" ]]; then
    cp "$build/$sde"/robots.txt "$dest/$de/htdocs/"
  fi
fi

# english site
if [[ -d "$build/$sen" ]]; then
  if [[ -d "$dest/$en/htdocs" ]]; then
    # delete js in home and about
    deletejs "$build/$sen/index.html"
    deletejs "$build/$sen/about/index.html"

    # copy html
    cd "$build/$sen/"
    html "$dest/$en/htdocs/"
  fi

  # copy robots txt
  if [[ -f "$build/$sen/robots.txt" ]]; then
    cp "$build/$sen"/robots.txt "$dest/$en/htdocs/"
  fi
fi

# french site
if [[ -d "$build/$sfr" ]]; then
  if [[ -d "$dest/$fr/htdocs" ]]; then
    # delete js in home and about
    deletejs "$build/$sfr/index.html"
    deletejs "$build/$sfr/about/index.html"

    # copy html
    cd "$build/$sfr/"
    html "$dest/$fr/htdocs/"
  fi

  # copy robots txt
  if [[ -f "$build/$sfr/robots.txt" ]]; then
    cp "$build/$sfr"/robots.txt "$dest/$fr/htdocs/"
  fi
fi

# russian site
if [[ -d "$build/$sru" ]]; then
  if [[ -d "$dest/$ru/htdocs" ]]; then
    # delete js in home and about
    deletejs "$build/$sru/index.html"
    deletejs "$build/$sru/about/index.html"

    # copy html
    cd "$build/$sru/"
    html "$dest/$ru/htdocs/"
  fi

  # copy robots txt
  if [[ -f "$build/$sru/robots.txt" ]]; then
    cp "$build/$sru"/robots.txt "$dest/$ru/htdocs/"
  fi
fi
