#! /usr/bin/env bash

# --- TODO --- #
# - Wenn AUR existiert, sollte er den install von yay skippen
# - Lazyvim 

# --- Variablen --- #
path_aur=$HOME/.yay/
path_oh_my_zsh=$HOME/.oh-my-zsh


# Synch mirrors
echo "Updating Mirrors"
sudo pacman -Syu
sleep 3

echo "Installing packet list"
xargs -a "$HOME/.config/scripts/pakete.txt" sudo pacman -S --needed
echo "Finished installing packets"
sleep 3

# Install Yay AUR
if pacman -Q yay &>/dev/null; then
  echo "YAY is installed"

  if [ -d "$path_aur" ]; then
    # path exists - cd directory and pull new version
    echo "AUR/YAY exists!... Building new Version!"
    sleep 3

    cd "$path_aur" || exit 1
    git pull
    makepkg -si
    echo "Finished installation for Yay"
    sleep 3
  else
    echo "YAY is installed, but path does not exist. Skipping update."
    sleep 3
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

if [ -d "$path_oh_my_zsh" ]; then
	echo "Oh-My-Zsh exists, running update!"
	sleep 3
	$ZSH/tools/upgrade.sh
else
	echo "Path not found, installing form github!"
	sleep 1
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo ""
	echo "Oh-My-Zsh installation finished!"
	sleep 3
fi

echo "Install.sh script finished."
	
