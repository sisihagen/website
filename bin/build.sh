#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

case "$1" in
  git)
    ssh-add /home/siefke/.ssh/github_ed
    git add . && git commit -m "Articles and fixes for week $weeknumber" &&  git push && git push github
  ;;

  version)
    npm version patch
  ;;

  *)

    # clean
    ./bin/clean.sh

    # folder
    ./bin/folder.sh

    # markdown clean
    ./bin/markdown_clean.sh

    # hugo build
    ./bin/hugo.sh hugobuild || exit

    # remove static folders inside of build
    if [[ -d "./public/build/de/static" ]]; then
      rm -r ./public/build/de/static
    fi

    if [[ -d "./public/build/en/static" ]]; then
      rm -r ./public/build/en/static
    fi

    if [[ -d "./public/build/fr/static" ]]; then
      rm -r ./public/build/fr/static
    fi

    if [[ -d "./public/build/ru/static" ]]; then
      rm -r ./public/build/ru/static
    fi

    # html
    ./bin/html.sh

    # assets
    ./bin/css.sh &
    ./bin/downloads.sh &
    ./bin/fonts.sh &
    ./bin/images.sh &
    ./bin/js.sh &
    wait

    # deploying
    ./bin/deploy.sh
  ;;
esac
