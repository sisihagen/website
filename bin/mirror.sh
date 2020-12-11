#!/usr/bin/env bash

# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# check the mirror folder is there
if [[ -d "$mirror" ]]; then
  # we start with the North America mirror
  if [[ -d "$mirror/$na" ]]; then
    # sync the dest with mirror North America
    sync "$dest/" "$mirror/$na/"

    # change provider and operating system
    # vultr.com
    sedmirror_vultr "$de"
    sedmirror_vultr "$en"
    sedmirror_vultr "$fr"
    sedmirror_vultr "$ru"
  fi

  if [[ -d "$mirror/$africa" ]]; then
    sync "$dest/" "$mirror/$africa/"
    sedmirror_oneprovider "$africa" "$de"
    sedmirror_oneprovider "$africa" "$en"
    sedmirror_oneprovider "$africa" "$fr"
    sedmirror_oneprovider "$africa" "$ru"
  fi

  if [[ -d "$mirror/$asia" ]]; then
    sync "$dest/" "$mirror/$asia/"
    sedmirror_oneprovider "$asia" "$de"
    sedmirror_oneprovider "$asia" "$en"
    sedmirror_oneprovider "$asia" "$fr"
    sedmirror_oneprovider "$asia" "$ru"
  fi
fi

# check pi folder is there and sync dest with pi
if [[ -d "$pi" ]]; then
  sync "$dest/$de/htdocs/" "$pi/"
  sync "$dest/$static/htdocs/" "$pi/static/"
  find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
  sedpi
fi
