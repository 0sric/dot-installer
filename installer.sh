#!/bin/bash

LOG_FILE="dotfile.log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "$(date +"%H:%M:%S"): $1"
}

# System update
log "Starting system update..."
sudo pacman -Syu --noconfirm
log "System updated. Proceeding..."

# Install yay
if ! command -v yay &>/dev/null; then
    log "yay is not installed. Downloading and installing..."
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si --noconfirm
    cd - || exit
    log "yay has been installed!"
else
    log "yay is already installed!"
fi

# Install neofetch
yay -S neofetch --noconfirm

# Install Polybar
log "Downloading and installing Polybar..."
git clone https://github.com/polybar/polybar
cd polybar || exit
mkdir build
cd build || exit
cmake ..
make -j$(nproc)
sudo make install
log "Polybar installed from GitHub repo."

# Install Rofi
log "Downloading and installing Rofi..."
git clone https://github.com/davatorium/rofi.git
cd rofi || exit
autoreconf -i
mkdir build
cd build || exit
../configure
make
sudo make install
log "Rofi installed from GitHub repo."

# Install Spotify and Spicetify
yay -S spotifyd --noconfirm
log "Spotifyd installed from AUR."

yay -S spicetify-cli --noconfirm
spicetify apply
log "Spicetify installed from AUR."

# Install Firefox
sudo pacman -S firefox --noconfirm
log "Firefox installed from official repositories."

# Install Zathura
yay -S zathura --noconfirm
log "Zathura installed from AUR."

# Install Fish shell
if ! command -v fish &>/dev/null; then
    log "Fish is not installed. Downloading and installing..."
    sudo pacman -S fish --noconfirm
    log "Fish installed from official repositories."
else
    log "Fish is already installed!"
fi

# Install Kitty
if ! command -v kitty &>/dev/null; then
    log "Kitty is not installed. Downloading and installing..."
    git clone https://aur.archlinux.org/kitty-git.git
    cd kitty-git || exit
    makepkg -si --noconfirm
    cd - || exit
    log "Kitty has been installed!"
else
    log "Kitty is already installed!"
fi

# Install Dolphin
log "Dolphin is not installed. Downloading and installing..."
sudo pacman -S dolphin --noconfirm
log "Dolphin installed from official repositories."

log "Installation script completed."
