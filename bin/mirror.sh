#!/usr/bin/env bash
# variables
source ./bin/variables.sh

# function
source ./bin/function.sh

# check the mirror folder is there
if [[ -d "$mirror" ]]; then
  # we start with the North America mirror
  if [[ -d "$mirror/$na" ]]; then
    # sync mirror North America
    sync "$dest/" "$mirror/$na/"

    # change provider and operating system
    # vultr.com
    sedmirror_vultr "$na" "$de"
    sedmirror_vultr "$na" "$en"
    sedmirror_vultr "$na" "$fr"
    sedmirror_vultr "$na" "$ru"
  fi

  # sync mirror Africa
  if [[ -d "$mirror/$africa" ]]; then
    sync "$dest/" "$mirror/$africa/"
    sedmirror_hostafrica "$africa" "$de"
    sedmirror_hostafrica "$africa" "$en"
    sedmirror_hostafrica "$africa" "$fr"
    sedmirror_hostafrica "$africa" "$ru"
  fi

#   # sync mirror Asia
  if [[ -d "$mirror/$asia" ]]; then
    sync "$dest/" "$mirror/$asia/"

    # change provider and operating system
    # vultr.com
    sedmirror_vultr "$asia" "$de"
    sedmirror_vultr "$asia" "$en"
    sedmirror_vultr "$asia" "$fr"
    sedmirror_vultr "$asia" "$ru"
  fi

#   # sync mirror South America
  if [[ -d "$mirror/$sa" ]]; then
    sync "$dest/" "$mirror/$sa/"

    # change provider and operating system
    # vultr.com
    sedmirror_hostafrica "$sa" "$de"
    sedmirror_hostafrica "$sa" "$en"
    sedmirror_hostafrica "$sa" "$fr"
    sedmirror_hostafrica "$sa" "$ru"
  fi
fi

# # check pi folder is there and sync dest with pi
# if [[ -d "$pi" ]]; then
#   sync "$dest/$de/htdocs/" "$pi/"
#   sync "$dest/$static/htdocs/" "$pi/static/"
#   find ./public/local -type f -name "*.html" -exec sed -i -e 's/silviosiefke.de/home.silviosiefke.com/g' {} \;
#   sedpi
#fi
