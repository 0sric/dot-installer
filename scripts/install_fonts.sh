#!/bin/bash

# Create a directory for fonts
mkdir -p ~/.local/share/fonts

# Hack Font
echo "Installing Hack Font..."
wget -O /tmp/hack.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip -j /tmp/hack.zip -d ~/.local/share/fonts/
rm /tmp/hack.zip

# Unifont
echo "Installing Unifont..."
sudo pacman -S ttf-unifont

# Siji Font
echo "Installing Siji Font..."
git clone --depth 1 https://github.com/stark/siji.git /tmp/siji
cd /tmp/siji
./install.sh
cd -
rm -rf /tmp/siji

# Font Awesome 5
echo "Installing Font Awesome 5..."
wget -O /tmp/fontawesome.zip https://fontawesome.com/v5.15.4/download/all.zip
unzip -j /tmp/fontawesome.zip 'fontawesome-free-5.15.4/webfonts/fa-brands-400.ttf' 'fontawesome-free-5.15.4/webfonts/fa-regular-400.ttf' 'fontawesome-free-5.15.4/webfonts/fa-solid-900.ttf' -d ~/.local/share/fonts/
rm /tmp/fontawesome.zip

# Update font cache
fc-cache -fv

echo "Fonts installed successfully!"
