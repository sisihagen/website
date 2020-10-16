#!/usr/bin/env bash

# hugp build
build='./public/build'
sde='de'
sen='en'
sfr='fr'
sru='ru'

# after build
dest='./public/dest'
de='silviosiefke.de'
en='silviosiefke.com'
fr='silviosiefke.fr'
ru='silviosiefke.ru'


# mirror
mirror='./public/mirror'
finnland='finnland'
jpy='jpy'
jburg='jburg'

# pi
pi='./public/local'

# static
lstatic='./static/static'
static='static.silviosiefke.com'
css='css'
img='img'
js='js'
fonts='fonts'
downloads='downloads'

# images
picture="$(find ./static/static/img/content ./static/static/img/cover -iregex ".*\.\(jpg\|png\|jpeg|svg\)$" | wc -l)"
webp="$(find ./static/static/img/content ./static/static/img/cover -type f -name "*.webp" | wc -l)"
webp_content="$(find ./static/static/img/content/"$year" -type f -name "*.webp" | wc -l)"
png_content="$(find ./static/static/img/content/"$year" -type f -name "*.png" | wc -l)"
jpg_content="$(find ./static/static/img/content/"$year" -type f -name "*.jpg" | wc -l)"
jpg_cover="$(find ./static/static/img/cover/"$year" -type f -name "*.jpg" | wc -l)"
webp_cover="$(find ./static/static/img/cover/"$year" -type f -name "*.webp"| wc -l )"


# time
date=$(date +"%Y-%m-%d")
year=$(date +%Y)
month=$(date +%m)
day=$(date +%d)
weeknumber=$(date +%V)


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



