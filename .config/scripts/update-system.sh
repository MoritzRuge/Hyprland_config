#! /usr/bin/env bash

# Script to update the system

checkupdates
sleep 1
paru -Syua
sleep 1

while true; do
  read -r -p "Do you wish to upgrade the system?(y/N): " answer
  case $answer in
  [Yy]*)
    echo "Upgrading the system!"
    sleep 0.5
    sudo pacman -Syu --noconfirm
    sleep 0.5
    pkgstats submit

    paru -Syua
    sleep 1
    flatpak upgrade -y
    echo "Completed the system upgrade!"
    sleep 1
    exit 0
    ;;
  [Nn]*)
    echo "Exiting script."
    exit 0
    ;;
  *) echo "Please answer Y or N." ;;
  esac
done
