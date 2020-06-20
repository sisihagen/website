#!/usr/bin/env bash
# created 14.06.2020
# Silvio Siefke <siefke@mail.ru>

#
# links which has help me
#
# https://forum.ubuntuusers.de/topic/ordner-verzeichnisnamen-in-array-speidhern/
# https://stackoverflow.com/questions/15402770/how-to-grep-and-replace
# https://stackoverflow.com/questions/62370875/search-and-delete-links-in-markdown-files


# read in variables
source ./bin/variables.sh

if [[ "$1" == "de" ]]; then

  # check internal links
  linkcheck https://silviosiefke.de > $deint

  # check external links
  htmltest -c ./htmtest_de.yml > $deext

  # fix the logfile, only save the 404 results
  sed -ni '/404/p' $deext

  # clean whitepace
  sed -i 's/  //g' $deext

  # run with loop and delete the 404 links
  IFS=$'\n'
  link=( $(awk '{print $7}' $deext) )

  for i in "${link[@]}"; do
    grep -ro "\[.*\].*${i}" content/* | grep -o '\[.*\]' | tr -d '[]'
  done

elif [[ "$1" == "en" ]]; then

  linkcheck https://silviosiefke.com > $enint

elif [[ "$1" == "fr" ]]; then

  linkcheck https://silviosiefke.fr > $frint

elif [[ "$1" == "ru" ]]; then

  linkcheck https://silviosiefke.ru > $ruint

fi
