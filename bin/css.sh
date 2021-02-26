#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# css
# check file exist
if [[ ! -f "$lstatic/$css/layout.css" ]]; then
  # compile to css and run autoprefixer
  sassc -t compressed -m $lstatic/scss/layout.scss | ./node_modules/.bin/postcss -u autoprefixer > $lstatic/css/layout.css

  # copy files to sync directory
  cp $lstatic/css/layout.css $dest/$static/htdocs/$css
else
    # copy files to sync directory
    sync "$lstatic/css/" "$dest/$static/htdocs/$css"
fi
