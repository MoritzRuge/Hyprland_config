#!/usr/bin/env bash

# Ordner für die Wallpaper
WALLPAPER_DIR="$HOME/.config/wallpapers"

# Liste der Wallpapers
WALLPAPERS=$(ls "$WALLPAPER_DIR")

# wofi erzeugt die Liste und gibt auswahl zurück
if command -v nsxiv >/dev/null; then
  SELECTED=$(nsxiv -otb $WALLPAPER_DIR)
else
  SELECTED=$(echo "$WALLPAPERS" | wofi --dmenu --prompt "Select Wallpaper:")
fi

# Falls etwas ausgewählt wurde, Wallpaper setzten
if [ -n "$SELECTED" ]; then
  swaybg -i "$SELECTED"
  #echo -e "preload = $SELECTED\nwallpaper = ,$SELECTED" >~/.config/hypr/hyprpaper.conf
  wal -i "$SELECTED" --contrast 2
fi
