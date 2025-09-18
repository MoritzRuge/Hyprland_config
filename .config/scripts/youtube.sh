#! /usr/bin/env bash

output_path="$HOME/Downloads/.temp_videos/"

if [ -z "$1" ]; then
  echo "Input Youtube link: "
  read youtube_link
else
  youtube_link="$1"
fi

if [ -z "$youtube_link" ]; then
  echo "Bitte link einfügen."
  exit 0
else
  echo "Downloading Video"
  echo "$youtube_link"

  # Video herunterladen und den Pfad speichern
  yt-dlp -o "$output_path%(title)s.%(ext)s" "$youtube_link"

  filename=$(yt-dlp --get-filename -o "$output_path%(title)s.%(ext)s" "$youtube_link")

  echo "Video heruntergeladen: $filename"
  mpv "$filename"

  #echo "Deleting file: '$filename'"
  #rm -v "$filename"
fi
