#!/usr/bin/env bash

# --- Threshhold --- #
threshhold_green=0
threshhold_yellow=25
threshhold_red=100

# --- Check for updates --- #

if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
  updates_arch=0
fi

if ! updates_aur=$(yay -Qu | wc -l); then
  updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

# --- output json --- #

css_class="green"

if [ "$updates" -lt "$threshhold_yellow" ]; then
  css_class="green"
elif [ "$updates" -lt "$threshhold_red"]; then
  css_class="yellow"
else
  css_class="red"
fi

if [ "$updates" -gt "$threshhold_green" ]; then
  printf '{"text": "%s", "alt": "%s", "tooltip": "%s Updates", "class": "%s"}' "$updates" "$updates" "$updates" "$css_class"
else
  printf '{"text": "0", "alt": "0", "tooltip": "0 Updates", "class": "green"}'
fi
