#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# js
if [[ -d $sst/js ]]; then
  # concat the used js files in one temporary js file
  cat ./node_modules/jquery/dist/jquery.js ./node_modules/flexibility/flexibility.js ./static/static/js/app.js > ./static/static/js/site-orig.js

  # minify the js file to the used js file in website
  ./node_modules/.bin/uglifyjs $sst/js/site-orig.js > $sst/js/site.js

  # copy used js files
  cp $sst/js/site.js $dst/js/site.js
  cp ./node_modules/html5shiv/dist/html5shiv.min.js $dst/js
  cp $sst/js/modernizr.js $dst/js/
fi
