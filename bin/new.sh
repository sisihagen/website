#!/usr/bin/env bash
# you append to the command the language, categories and the title
# the script build a file and create the head content of it
# the script also generate a english based filename

# variables through user input
lang=$1
cover=$2
tmp_title=$3

# variables which we use in script
# create a title with small letters and remove whitespace
title=$(echo ${tmp_title,,} | trans -brief :en | sed -e 's/\s/-/g')

# categories
categories=(computer media repression society)

# date variables
date=$(date +"%Y-%m-%d")
year=$(date +"%Y")
month=$(date +"%m")

# content variables
content_dir="./content/$lang/blog/$year/$month"
file="$content_dir/$title.md"

# function
function create_file()
{
  {
    echo "---"
    echo "title: \"$tmp_title\""
    echo "date: $date"
    echo "draft: false"
    echo "tags: \"$tag\""
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
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Computer"

        elif [[ $cover =~ "media" ]]; then
          tag="Medien"

        elif [[ $cover =~ "repression" ]]; then
          tag="Staat"


        elif [[ $cover =~ "society" ]]; then
          tag="Gesellschaft"
        fi

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
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Computer"

        elif [[ $cover =~ "media" ]]; then
          tag="Media"

        elif [[ $cover =~ "repression" ]]; then
          tag="State"

        elif [[ $cover =~ "society" ]]; then
          tag="Society"
        fi

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
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Ordinateur"

        elif [[ $cover =~ "media" ]]; then
          tag="Journalisme"

        elif [[ $cover =~ "repression" ]]; then
          tag="Politique"

        elif [[ $cover =~ "society" ]]; then
          tag="Société"
        fi

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
      if [[ ${categories[*]} =~ $cover ]]; then

        # translation tag > categories
        if [[ $cover =~ "computer" ]]; then
          tag="Компьютер"

        elif [[ $cover =~ "media" ]]; then
          tag="СМИ"

        elif [[ $cover =~ "repression" ]]; then
          tag="штат"

        elif [[ $cover =~ "society" ]]; then
          tag="Общество"
        fi

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
    echo "./bin/new.sh lang cover title"
    echo "./bin/news.sh en society 'This is a title'"
    echo "cover: computer, media, repression, society"
  ;;
esac
