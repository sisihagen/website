#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh

# clean
./bin/clean.sh

# folder
./bin/folder.sh

# markdown clean
./bin/markdown_clean.sh

# hugo build
./bin/hugo.sh hugobuild

# html
./bin/html.sh

# assets
./bin/css.sh
./bin/downloads.sh
./bin/fonts.sh
./bin/images.sh
./bin/js.sh

# deploy
./bin/deploy.sh

# raspi
./bin/raspi.sh
