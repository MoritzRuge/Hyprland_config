#! /usr/bin/env bash

# --- TODO --- #
# - Wenn AUR existiert, sollte er den install von yay skippen
# - git first initialisation git config --global user.name / user.email

# --- Variablen --- #
path_aur=$HOME/.yay/
path_oh_my_zsh=$HOME/.oh-my-zsh
timer=3

# --- Synch mirrors --- #
echo "Updating Mirrors"
sudo pacman -Sy
sleep "$timer"

echo "Installing Pacman packet list..."
xargs -a "$HOME/.config/scripts/pakete.txt" sudo pacman -S --needed
echo "Finished installing packets"
sleep "$timer"


# --- Install Yay AUR --- #

if pacman -Q yay &>/dev/null; then
  echo "YAY is installed"

  if [ -d "$path_aur" ]; then
    # path exists - cd directory and pull new version
    echo "AUR/YAY exists!... Building new Version!"
    sleep "$timer"

    cd "$path_aur" || exit 1
    git pull
    makepkg -si
    echo "Finished installation for Yay"
    sleep "$timer"
  else
    echo "YAY is installed, but path does not exist. Skipping update."
    sleep "$timer"
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


# --- Oh-My-Zsh installation --- #

if [ -d "$path_oh_my_zsh" ]; then
	echo "Oh-My-Zsh exists, running update!"
	sleep "$timer"
	$ZSH/tools/upgrade.sh
else
	echo "Path not found, installing form github!"
	sleep "$timer"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo ""
	echo "Oh-My-Zsh installation finished!"
	sleep "$timer"
fi


# --- switch to zsh shell --- #
zsh


echo "Install.sh script finished."
	
