#!/usr/bin/env bash

# read in variables
source ./bin/variables.sh
source ./bin/function.sh

# clean dest folders
if [[ -d "./public" ]]; then
  if [[ -d "./public/build" ]]; then
    rm -r ./public/build
  fi

  if [[ -d "./public/local" ]]; then
    rm -r ./public/local
  fi

  if [[ -d "./public/dest/silviosiefke.de" ]]; then
    rm -r ./public/dest/silviosiefke.de
  fi

  if [[ -d "./public/dest/silviosiefke.com" ]]; then
    rm -r ./public/dest/silviosiefke.com
  fi

  if [[ -d "./public/dest/silviosiefke.fr" ]]; then
    rm -r ./public/dest/silviosiefke.fr
  fi

  if [[ -d "./public/dest/silviosiefke.ru" ]]; then
    rm -r ./public/dest/silviosiefke.ru
  fi
fi
