#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh

# html clean and minify for all languages
if [[ -d $sde ]]; then
    if [[ -d $dde ]]; then
      find $sde -name "index.xml" -delete
      rm -r $sde/static
      minify --type=html --html-keep-document-tags --html-keep-end-tags --html-keep-quotes -r -o $dde/ $sde/
      cp $sde/robots.txt $dde/
    fi
fi

if [[ -d $sen ]]; then
    if [[ -d $den ]]; then
      find $sen -name "index.xml" -delete
      rm -r $sen/static
      minify --type=html --html-keep-document-tags --html-keep-end-tags --html-keep-quotes -r -o $den/ $sen/
      cp $sen/robots.txt $den/
    fi
fi

if [[ -d $sfr ]]; then
    if [[ -d $dfr ]]; then
      find $sfr -name "index.xml" -delete
      rm -r $sfr/static
      minify --type=html --html-keep-document-tags --html-keep-end-tags --html-keep-quotes -r -o $dfr/ $sfr/
      cp $sfr/robots.txt $dfr/
    fi
fi

if [[ -d $sru ]]; then
    if [[ -d $dru ]]; then
      find $sru -name "index.xml" -delete
      rm -r $sru/static
      minify --type=html --html-keep-document-tags --html-keep-end-tags --html-keep-quotes -r -o $dru/ $sru/
      cp $sru/robots.txt $dru/
    fi
fi
