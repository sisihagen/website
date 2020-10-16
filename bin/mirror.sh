#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# check the mirror folder is there
if [[ -d "$mirror" ]]; then
  # we start with the finnland mirror
  if [[ -d "$mirror/$finnland" ]]; then
    # sync the dest with mirror finnland
    sync "$dest/" "$mirror/$finnland/"

    # change provider and operating system
    # hetzner
    sedmirror_hetzner "$de"
    sedmirror_hetzner "$en"
    sedmirror_hetzner "$fr"
    sedmirror_hetzner "$ru"
  fi

  if [[ -d "$mirror/$jburg" ]]; then
    sync "$dest/" "$mirror/$jburg/"
    sedmirror_oneprovider "$jburg" "$de"
    sedmirror_oneprovider "$jburg" "$en"
    sedmirror_oneprovider "$jburg" "$fr"
    sedmirror_oneprovider "$jburg" "$ru"
  fi

  if [[ -d "$mirror/$jpy" ]]; then
    sync "$dest/" "$mirror/$jpy/"
    sedmirror_oneprovider "$jpy" "$de"
    sedmirror_oneprovider "$jpy" "$en"
    sedmirror_oneprovider "$jpy" "$fr"
    sedmirror_oneprovider "$jpy" "$ru"
  fi
fi

# check pi folder is there and sync dest with pi
if [[ -d "$pi" ]]; then
  sync "$dest/$de/htdocs/" "$pi/"
  sync "$dest/$static/htdocs/" "$pi/static/"
  find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
  sedpi
fi
