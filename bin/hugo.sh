#!/usr/bin/env bash

source ./bin/variables.sh

case "$1" in
    help)
          echo "build     > Running all gulp production tasks"
          echo "hugobuild > only build page with hugo"
          echo "default   > running the hugo Development Server"
    ;;

    build)
        ./bin/build.sh
    ;;

    hugobuild)
        # run hugo
        hugo --cleanDestinationDir --enableGitInfo --gc --minify
    ;;

    *)
        hugo server -D --i18n-warnings --watch --ignoreCache --verbose --disableFastRender
    ;;
esac
