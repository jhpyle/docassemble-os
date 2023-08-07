#!/usr/bin/env bash
if [[ "$(dpkg --print-architecture)" == "amd64" ]]
then
  wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  dpkg -i ./google-chrome-stable_current_amd64.deb
  rm ./google-chrome-stable_current_amd64.deb
fi
