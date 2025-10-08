#! /usr/bin/env bash

# check if iwd or NetworkManager is running
if systemctl is-active --quiet iwd; then
  PROGRAM="impala"
elif systemctl is-active --quiet NetworkManager; then
  PROGRAM="nmtui"
else
  notify-send "No appropriate Network-Program is running"
  exit 1
fi

# start tui
foot "$PROGRAM"
