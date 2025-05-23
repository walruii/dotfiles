#!/bin/bash

# getting the os
var=$(grep ID_LIKE /etc/os-release)
packages="git neovim zip unzip zoxide gcc zsh nodejs python3 tmux lua npm"
# gh

if [[ "$var" == *"ID_LIKE=debian"* ]]; then
  # if debian based then update it
  sudo apt-get update
  sudo apt-get install -y $packages gh
else
  # then it is arch so update that
  sudo pacman -Syu --noconfirm --needed base-devel $packages github-cli
  git clone https://aur.archlinux.org/yay.git ~/yay
  cd ~/yay && makepkg -si
  cd ~/dotfiles || exit 1;
fi

# install nodejs / language support
sudo npm install -g npm@latest
sudo npm install -g vscode-langservers-extracted typescript typescript-language-server @tailwindcss/language-server

# config files for nvim and zsh
git clone https://github.com/walruii/arch-nvim.git ~/.config/nvim
git clone https://github.com/walruii/dotfiles.git ~/dotfiles

# installing oh my zsh and setting up config
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
