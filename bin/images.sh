#!/usr/bin/env bash

# images
wdir="./static/static/img/"
odir="./public/dest/static.silviosiefke.com/htdocs/img/"
jpgo="$(find $wdir -name "*.jpg" -mtime -1 -type f -exec jpegoptim -q {} \;)"
pngo="$(find $wdir -name "*.png" -mtime -1 -type f -exec pngfix -o -q {} \;)"
webp="$(find $wdir -iregex ".*\.\(jpg\|png\|jpeg\)$" -mtime -1 -type f | parallel -eta cwebp -quiet {} -o {.}.webp)"

if [[ $jpgo -eq 0 && $pngo -eq 0 && $webp -eq 0  ]] ; then
  rsync -auq $wdir $odir
fi
