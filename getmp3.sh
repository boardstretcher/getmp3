#!/bin/bash
# Debian

## Dependancies
dpkg --list | grep python3 &>/dev/null
if [[ $? -eq 1 ]]
then
    sudo apt-get install -y python3
fi

dpkg --list | grep python3-pip &>/dev/null
if [[ $? -eq 1 ]]
then
    sudo apt-get install -y python3-pip
fi

dpkg --list | grep ffmpeg &>/dev/null
if [[ $? -eq 1 ]]
then
    sudo apt-get install -y ffmpeg
fi

pip3 list | grep yewtube &>/dev/null
if [[ $? -eq 1 ]]
then
    sudo pip3 install --upgrade yewtube
fi

## Main Logic
mkdir temp_download
yt set search_music true,/$1,set encoder 0,set ddir ./temp_download,da 1,exit
for FILE in temp_download/*; do T="${FILE%.webm}.mp3"; ffmpeg -i "${FILE}" -vn -ab 128k -y ${2:-"${T#temp_download/}"}; done
rm -r temp_download
