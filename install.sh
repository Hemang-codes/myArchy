#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Get the absolute path of this script's location
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE}")" &>/dev/null && pwd)

echo "🚀 Starting myArchy system deployment..."

# 1. Update the core system & Install packages
echo "🔄 Updating system and installing packages..."
sudo pacman -Syu --noconfirm
if [ -f "$SCRIPT_DIR/packages.txt" ]; then
  grep -v '^#' "$SCRIPT_DIR/packages.txt" | grep -v '^$' | xargs sudo pacman -S --needed --noconfirm
fi

# 2. Create base configuration directories
mkdir -p ~/.config
mkdir -p ~/Pictures/Wallpapers

# 3. Copy/Deploy custom wallpaper
if [ -d "$SCRIPT_DIR/wallpapers" ]; then
  echo "🖼️ Deploying custom wallpapers to ~/Pictures/Wallpapers/..."
  cp -r "$SCRIPT_DIR/wallpapers/." ~/Pictures/Wallpapers/
else
  echo "⚠️ No wallpapers folder found in repo, skipping wallpaper copy."
fi

# 4. Loop through and link your specific config folders
echo "🔗 Symlinking configuration directories..."
for folder in alacritty btop fish hypr nemo neofetch nvim waybar; do
  if [ -d "$SCRIPT_DIR/$folder" ]; then
    echo "Linking $folder -> ~/.config/$folder"
    ln -sfn "$SCRIPT_DIR/$folder" ~/.config/"$folder"
  fi
done

# 5. Set Fish as the default user shell
if [ "$SHELL" != "/usr/bin/fish" ]; then
  echo "🐚 Setting Fish as the default shell..."
  chsh -s /usr/bin/fish
fi

echo "🎉 Deployment complete! Log out and back in."
