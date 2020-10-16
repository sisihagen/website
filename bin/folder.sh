#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# create folder
# build folder
mkdir -p $build

# sites folder
mkdir -p $dest/{$de,$fr,$en,$ru}/htdocs

# pi
mkdir $pi

# mirror folder
mkdir -p $mirror/{$finnland,$jburg,$jpy}

# sites folder for mirrors
mkdir -p $mirror/$finnland/{$de,$fr,$en,$ru}/htdocs
mkdir -p $mirror/$jburg/{$de,$fr,$en,$ru}/htdocs
mkdir -p $mirror/$jpy/{$de,$fr,$en,$ru}/htdocs

# static folder
mkdir -p $dest/$static/htdocs/{$css,$img,$downloads,$js,$fonts}
