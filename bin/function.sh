#!/usr/bin/env bash

# for new.sh
function clean_dir()
{
  if [[ "$(ls -A $tmp_dir)" ]]; then
    rm $tmp_dir/*.md
  fi
}

# for new.sh
function clean_file()
{
  if [[ -s "$tmp" ]]; then
    truncate -s 0 $tmp
  fi
}

# for new.sh
function copy_files()
{
  for i in "${source[@]}" ; do
    cp "$i" "$tmp_dir"
  done
}

# create md file header
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
