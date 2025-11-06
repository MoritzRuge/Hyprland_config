#!/bin/bash

if pacman -Qs wlogout >/dev/null; then
  wlogout
else
  selection=$(echo "Sleep
  Log out
  Reboot
  Shutdown
  Shutdown Now" | wofi -dmenu)
fi

if [[ $selection == "Shutdown" ]]; then
  hyprctl notify 3 30000 "rgb(ff0000)" "Shutdown scheduled"
  sleep 30
  systemctl poweroff
elif [[ $selection == "Reboot" ]]; then
  systemctl reboot
elif [[ $selection == "Shutdown Now" ]]; then
  systemctl poweroff
elif [[ $selection == "Log out" ]]; then
  loginctl terminate-user $USER
elif [[ $selection == "Sleep" ]]; then
  systemctl suspend
else
  hyprctl dismissnotify &>/dev/null
  killall powerMenu.sh
fi
