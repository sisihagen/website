#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# check the image folder exist
if [[ ! -d "$dest/$static/htdocs/img/" ]]; then
  if [[ -d "$lstatic/$img" ]]; then
    # first we check we have png files in folder
    if [[ ! -z $png_content ]]; then
      # convert png to jpg in content image folder
      png "content"
    fi

    # check jpg and webp are same in content folder and when not convert them
    if ! [[ "$jpg_content" == "$webp_content" ]]; then
      # convert jpg to webp
      images "content"
      diff ./jpg.txt ./webp.txt | awk '{print $2}' | sed '/^$/d' > ./diff.txt
      alignthem
    fi

    # # check jpg and webp are same in content folder and when not convert them
    if ! [[ "$jpg_cover" == "$webp_cover" ]]; then
      # convert jpg to webp
      images "cover"
      diff ./jpg.txt ./webp.txt | awk '{print $2}' | sed '/^$/d' > ./diff.txt
      alignthem
    fi

    # all checks ok we syn the folder
    sync "$lstatic/img/" "$dest/$static/htdocs/img/"

  fi
else
  if [[ $(find "$lstatic/scss" -mtime -1 -type f 2>/dev/null ) ]]; then
    if [[ -d "$lstatic/$img" ]]; then
      # first we check we have png files in folder
      if [[ ! -z $png_content ]]; then
        # convert png to jpg in content image folder
        png "content"
      fi

      # check jpg and webp are same in content folder and when not convert them
      if ! [[ "$jpg_content" == "$webp_content" ]]; then
        # convert jpg to webp
        images "content"
        diff ./jpg.txt ./webp.txt | awk '{print $2}' | sed '/^$/d' > ./diff.txt
        alignthem
      fi

      # # check jpg and webp are same in content folder and when not convert them
      if ! [[ "$jpg_cover" == "$webp_cover" ]]; then
        # convert jpg to webp
        images "cover"
        diff ./jpg.txt ./webp.txt | awk '{print $2}' | sed '/^$/d' > ./diff.txt
        alignthem
      fi

      # all checks ok we syn the folder
      sync "$lstatic/img/" "$dest/$static/htdocs/img/"
    fi
  fi
fi

# check folder are sync
if [[ -d "$lstatic/img/" ]]; then
  sync "$lstatic/img/" "$dest/$static/htdocs/img/"
fi
