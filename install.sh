#!/bin/bash
# myArchy installer.
# Run as your normal user (not root) on an Arch install that already has sudo + internet.
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
CONFIG_DIRS=(alacritty btop fish hypr nemo neofetch nvim waybar)
USER_NAME=$(id -un)

if [ "$(id -u)" -eq 0 ]; then
  echo "Run this as your normal user, not root." >&2
  exit 1
fi

echo "==> Updating system and installing official packages..."
sudo pacman -Syu --noconfirm
grep -v -e '^[[:space:]]*#' -e '^[[:space:]]*$' "$SCRIPT_DIR/packages.txt" \
  | sudo pacman -S --needed --noconfirm -

echo "==> Setting up yay (AUR helper)..."
if ! command -v yay &>/dev/null; then
  tmp=$(mktemp -d)
  git clone https://aur.archlinux.org/yay-bin.git "$tmp/yay-bin"
  (cd "$tmp/yay-bin" && makepkg -si --noconfirm)
  rm -rf "$tmp"
fi

echo "==> Installing AUR packages (one at a time, failures are reported but not fatal)..."
if [ -f "$SCRIPT_DIR/aur_packages.txt" ]; then
  while read -r pkg; do
    [[ -z "$pkg" || "$pkg" == \#* ]] && continue
    yay -S --needed --noconfirm "$pkg" || echo "WARNING: failed to install AUR package: $pkg"
  done < "$SCRIPT_DIR/aur_packages.txt"
fi

echo "==> Creating directories and copying wallpapers..."
mkdir -p "$HOME/.config" "$HOME/Pictures/Screenshot"
if [ -d "$SCRIPT_DIR/wallpaper" ]; then
  mkdir -p "$HOME/Pictures/wallpaper"
  cp -r "$SCRIPT_DIR/wallpaper/." "$HOME/Pictures/wallpaper/"
else
  echo "WARNING: no wallpaper/ folder in the repo. hyprpaper and hyprlock expect ~/Pictures/wallpaper/wall.png"
fi

echo "==> Symlinking config directories (existing real directories are backed up)..."
for folder in "${CONFIG_DIRS[@]}"; do
  src="$SCRIPT_DIR/$folder"
  dest="$HOME/.config/$folder"
  [ -d "$src" ] || continue
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    backup="$dest.bak.$(date +%s)"
    echo "Backing up existing $dest -> $backup"
    mv "$dest" "$backup"
  fi
  echo "Linking $folder -> ~/.config/$folder"
  ln -sfn "$src" "$dest"
done

echo "==> Linking helper scripts from bin/ into ~/.local/bin (if the repo has a bin/ folder)..."
if [ -d "$SCRIPT_DIR/bin" ]; then
  mkdir -p "$HOME/.local/bin"
  for f in "$SCRIPT_DIR"/bin/*; do
    [ -f "$f" ] || continue
    chmod +x "$f"
    ln -sf "$f" "$HOME/.local/bin/$(basename "$f")"
  done
fi

echo "==> Enabling services..."
for svc in sddm NetworkManager bluetooth; do
  sudo systemctl enable "$svc" || echo "WARNING: could not enable $svc (is another display manager already enabled?)"
done

echo "==> Preparing ddcutil (monitor input switching)..."
echo i2c-dev | sudo tee /etc/modules-load.d/i2c-dev.conf >/dev/null
if getent group i2c >/dev/null; then
  sudo usermod -aG i2c "$USER_NAME"
else
  echo "NOTE: no 'i2c' group found; see the ddcutil docs for permissions."
fi

echo "==> Setting fish as the default shell..."
if [ "$(getent passwd "$USER_NAME" | cut -d: -f7)" != "/usr/bin/fish" ]; then
  chsh -s /usr/bin/fish
fi

cat <<'MSG'

Deployment complete. Log out and back in (or reboot).

One-time step after your first Hyprland login (hyprpm needs a running session):
  hyprpm update
  hyprpm add https://github.com/hyprwm/hyprland-plugins
  hyprpm enable hyprbars

MSG
