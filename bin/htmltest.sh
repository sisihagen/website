#!/usr/bin/env bash
# created 14.06.2020
# Silvio Siefke <siefke@mail.ru>

#
# links which has help me
#
# https://forum.ubuntuusers.de/topic/ordner-verzeichnisnamen-in-array-speidhern/
# https://stackoverflow.com/questions/15402770/how-to-grep-and-replace
# https://stackoverflow.com/questions/62370875/search-and-delete-links-in-markdown-files
# https://www.unix.com/shell-programming-and-scripting/45885-grep-string-line-number.html
# shopt -s globstar | sed -i 's|oldlink|newlink|g' content/**/*.md
# curl -s -o /dev/null -I -w "%{http_code}" link-to-check
# grep -ro "\[.*\].*${i}" content/* | grep -o '\[.*\]' | tr -d '[]'


# read in variables
source ./bin/variables.sh

if [[ "$1" == "de" ]]; then
  # clean the filesystem
  rm $deint $deext_tmp $deext $statuscodes

  # check internal links
  linkcheck https://silviosiefke.de > $deint

  # check external links
  htmltest -c .htmltest_de.yml > $deext_tmp

  # fix the logfile, only save the 404 results
  sed -ni -e '/404/p' $deext_tmp

  # clean whitepace
  sed -i 's/  //g' $deext_tmp

  # delete "target" if exist
  sed -i '/target does not exist/d' $deext_tmp

  # copy lines to new log
  awk '{print $7}' $deext_tmp > $deext

  # delete the tmp file
  rm $deext_tmp

  # read log in and check http status
  while read line; do
    curl --write-out "%{http_code}\n" --silent --output /dev/null $line >> $statuscodes
  done < $deext

  # run with loop and delete the 404 links
  IFS=$'\n'
  linenumber=( $(grep -n 404 $statuscodes | sed 's/:404//g')  )

  # grep the line from $deext over $statuscodes
  for i in "${linenumber[@]}"; do
    awk "NR==$i" $deext >> $deext_tmp ;
  done

  # open file to see what links are wrong
  subl $deext_tmp

elif [[ "$1" == "en" ]]; then

  linkcheck https://silviosiefke.com > $enint

elif [[ "$1" == "fr" ]]; then

  linkcheck https://silviosiefke.fr > $frint

elif [[ "$1" == "ru" ]]; then

  linkcheck https://silviosiefke.ru > $ruint

fi
