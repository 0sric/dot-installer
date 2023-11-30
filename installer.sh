#!/bin/bash

LOG_FILE="dotfile.log"
exec > >(tee -a "$LOG_FILE") 2>&1

log() {
    echo "$(date +"%H:%M:%S"): $1"
}

# System update
log "Starting system update..."
sudo pacman -Syy
sudo pacman -Syu
log "System updated. Proceeding..."

# Install yay
if ! command -v yay &>/dev/null; then
    log "yay is not installed. Downloading and installing..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    log "yay has been installed!"
else
    log "yay is already installed!"
fi

# Install neofetch
yay -S neofetch


# ------------------------------------
# download polybar


git clone https://github.com/polybar/polybar
cd polybar
mkdir build
cd build
cmake ..
make -j$(nproc)
sudo make install
log "Polybar installed from GitHub repo."

# ------------------------------------
#download rofi

git clone https://github.com/davatorium/rofi.git
cd rofi
autoreconf -i
mkdir build
cd build
../configure
make
sudo make install

Echo “Rofi installed from github repo”
log() {
    echo "$(date +"%H:%M:%S: Rofi installed….")”
}



# Install spicetify and spotifyd
yay -S spotifyd

sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
log "Spotify installed from AUR."

yay -S spicetify-cli

spicetify apply
log "Spicetify installed from AUR."


# Install firefox and zathura
sudo pacman -S firefox
log "Firefox installed from official repositories."

yay -S zathura
log "Zathura installed from AUR."

# Install fish shell
if ! command -v fish &>/dev/null; then
    log "fish is not installed. Downloading and installing..."
    sudo pacman -S fish
    log "Fish installed from official repositories."
else
    log "fish is already installed!"
fi

# Add more installations here...

sudo pacman -S xxhash

# Install kitty
if ! command -v kitty &>/dev/null; then
    log "kitty is not installed. Downloading and installing..."
    git clone https://aur.archlinux.org/kitty-git.git
    cd kitty-git && makepkg -si --noconfirm
    cd ..
    log "kitty has been installed!"
else
    log "kitty is already installed!"
fi

log "Dolphin is not installed. Downloading and installing..."
sudo pacman -S dolphin
log "Dolphin installed from official repositories."

log "Installation script completed."
