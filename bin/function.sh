#!/usr/bin/env bash

function clean_dir()
{
  if [[ "$(ls -A $tmp_dir)" ]]; then
    rm $tmp_dir/*.md
  fi
}

function clean_file()
{
  if [[ -s "$tmp" ]]; then
    truncate -s 0 $tmp
  fi
}

function copy_files()
{
  for i in "${source[@]}" ; do
    cp "$i" "$tmp_dir"
  done
}
