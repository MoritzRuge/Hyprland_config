#! /usr/bin/env bash

FOLDER="$HOME/Downloads/.temp_videos/"

openvid() {
  NAME="$(echo "$(command ls $FOLDER)" | wofi --dmenu)" || exit 0
  mpv "$FOLDER$NAME" >/dev/null 2>&1
}

openvid
