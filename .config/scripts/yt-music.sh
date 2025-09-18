#!/usr/bin/env bash

yt_link=$1
artist=$2

directory=~/Music/"$artist"

if [ -d $directory ]; then
  echo "changing into $directory"
  cd directory
else
  mkdir -p $directory
  echo "Create and changing into: $directory"
  cd $directory
fi

yt-dlp \
  -x --audio-format mp3 \
  --add-metadata \
  --metadata-from-title "%(artist)s - %(title)s" \
  --parse-metadata "artist:$artist" \
  "$yt_link"
