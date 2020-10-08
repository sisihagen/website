#!/usr/bin/env bash

sde=./public/build/de
dde=./public/dest/silviosiefke.de/htdocs
sen=./public/build/en
den=./public/dest/silviosiefke.com/htdocs
sfr=./public/build/fr
dfr=./public/dest/silviosiefke.fr/htdocs
sru=./public/build/ru
dru=./public/dest/silviosiefke.ru/htdocs
sst=./static/static
dst=./public/dest/static.silviosiefke.com/htdocs

workdir=public/dest
de=silviosiefke.de/htdocs
en=silviosiefke.com/htdocs
fr=silviosiefke.fr/htdocs
ru=silviosiefke.ru/htdocs
st=static.silviosiefke.com/htdocs

# time
date=$(date +"%Y-%m-%d")
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
weeknumber=$(date +%V)

img_dir='./static/static/img/content'
jpeg_file='jpg.txt'
webp_file='webp.txt'
diff_file='diff.txt'
tmp='/tmp/source.txt'
tmp_dir='/tmp/md'
mdde='./content/de/blog'
mden='./content/en/blog'
mdfr='./content/fr/blog'
mdru='./content/ru/blog'

deext='./tmp/link_ext_de.log'
deext_tmp='./tmp/link_ext_de_tmp.log'
deint='./tmp/link_int_de.log'
enint='./tmp/link_int_en.log'
frint='./tmp/link_int_fr.log'
ruint='./tmp/link_int_ru.log'
statuscodes='./tmp/statuscodes.log'

# variables through user input
lang=$1
cover=$2
tmp_title=$3

# variables which we use in script
# create a title with small letters and remove whitespace
title=$(echo ${tmp_title,,} | trans -brief :en | sed -e 's/\s/-/g')
categories=(computer media repression society)
content_dir="./content/$lang/blog/$year/$month"
file="$content_dir/$title.md"
