#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# sites folder
mkdir -p $dest/{$de,$fr,$en,$ru}/htdocs

# static folder
if [[ ! -d "$dest/$static" ]]; then
  mkdir -p $dest/$static/htdocs/{$css,$img,$downloads,$js,$fonts} || exit
fi

# pi
mkdir $pi
