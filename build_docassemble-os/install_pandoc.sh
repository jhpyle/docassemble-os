#!/usr/bin/env bash
if [[ "$(dpkg --print-architecture)" == "amd64" ]]
then
  wget -q https://github.com/jgm/pandoc/releases/download/3.1.6/pandoc-3.1.6-1-amd64.deb
  dpkg -i pandoc-3.1.6-1-amd64.deb
  rm pandoc-3.1.6-1-amd64.deb;
elif [[ "$(dpkg --print-architecture)" == "arm64" ]]
then
  wget -q https://github.com/jgm/pandoc/releases/download/3.1.6/pandoc-3.1.6-1-arm64.deb
  dpkg -i pandoc-3.1.6-1-arm64.deb
  rm pandoc-3.1.6-1-arm64.deb
fi
