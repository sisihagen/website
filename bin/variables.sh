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

year=$(date +%Y)
month=$(date +%m)
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
