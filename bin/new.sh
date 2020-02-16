#!/usr/bin/env bash

# variables through user input
lang=$1
tags=$2
tmp_title=$3
cover=$4

# variables which we use in script
# create a title with small letters and remove whitespace
title=$(echo ${tmp_title,,} | sed -e 's/\s/-/g')

# date variables
date=$(date +"%Y-%m-%d")
year=$(date +"%Y")
month=$(date +"%m")

# content variables
content_dir="./content/$lang/blog/$year/$month"
file="$content_dir/$title.md"

# language tag arrays
de=(computer medien staat gesellschaft)
en=(computer media state society)
fr=(ordinateur journalisme politique société)
ru=(Компьютер СМИ штат общество)

# function
function create_file()
{
  {
    echo "---"
    echo "title: \"$tmp_title\""
    echo "date: $date"
    echo "draft: false"
    echo "tags: \"$tags\""
    echo "shorttext:"
    echo "cover: \"$cover\""
    echo "lang: $lang"
    echo "---"
  } >> "$file"
}

case $1 in
  de)
    if test -n "$lang"; then
      # check tag is in array
      if [[ ${de[*]} =~ $tags ]]; then

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  en)
    if test -n "$lang"; then
      # check tag is in array
      if [[ ${en[*]} =~ $tags ]]; then

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  fr)
    if test -n "$lang"; then
      # check tag is in array
      if [[ ${fr[*]} =~ $tags ]]; then

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  ru)

    if test -n "$lang"; then
      # check tag is in array
      if [[ ${ru[*]} =~ $tags ]]; then

        # check the folder structure is right
        if [[ -d "$content_dir" ]]; then

          # create the content and fill up the file
          create_file

          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        else

          # create the folder of content
          mkdir -p "$content_dir"

          # create the content and fill up the file
          create_file


          if [[ -f "$file" ]]; then
            subl "$file"
          fi

        fi
      else
        echo "Enter a valid tag name ..."
      fi
    fi
  ;;

  info)
    echo "To work with this script you need append the follow stuff"
    echo "./bin/new.sh lang tags title cover"
    echo "./bin/news.sh en society 'This is a title' society"
  ;;
esac
