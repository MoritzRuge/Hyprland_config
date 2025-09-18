#! /usr/bin/env bash

# Mögliches install script
# Vllt erstmal nur die gewünschten Packete an Pacman übergeben und AUR installieren

# Synch mirrors
echo "Updating Mirrors"
sudo pacman -Syu

echo "Installing packet list"
xargs -a "$HOME/.config/scripts/pakete.txt" sudo pacman -S --needed
echo "Finished installing packets"

# Install Yay AUR
path_aur=$HOME/.yay/
if pacman -Q yay &>/dev/null; then
  echo "YAY is installed"

  if [ -d "$path_aur" ]; then
    # path exists - cd directory and pull new version
    echo "AUR/YAY exists!... Building new Version!"
    cd "$path_aur" || exit 1
    git pull
    makepkg -si
    echo "Finished installation for Yay"
  else
    echo "YAY is installed, but path does not exist. Skipping update."
  fi

else
  echo "AUR/YAY does not exsist. Installing from git."

  sudo pacman -S --needed git base-devel

  git clone https://aur.archlinux.org/yay.git "$path_aur"
  cd "$path_aur" || exit 1

  echo "Building YAY from source..."
  makepkg -si --noconfirm
  echo "Finished installing YAY"
fi
