myArchy

# 🏗️ Arch Linux Custom Setup: Hyprland + Waybar

A minimal, modern, and highly customizable Wayland desktop environment using **Hyprland** and **Waybar** on Arch Linux. Built for productivity, aesthetics, and efficiency.

## ✨ Features

- **🪟 Hyprland** - Modern tiling Wayland compositor with superior performance
- **📊 Waybar** - Highly customizable system status bar
- **⚡ Minimal & Fast** - Lightweight, responsive, and battery-efficient
- **🎨 Beautiful** - Sleek themes and animations
- **⌨️ Keyboard-Driven** - Efficient, distraction-free workflow
- **🔧 Highly Configurable** - Customize every aspect to your needs

---

## 📋 Prerequisites

- Arch Linux or Arch-based distribution
- Basic terminal/CLI knowledge
- NVIDIA/AMD GPU (Intel iGPU works too)

---

## 🚀 Installation

### 1. Fresh Arch Linux Install

Follow the official [Arch Linux Installation Guide](https://wiki.archlinux.org/title/installation_guide)

### 2. Update System

```bash
sudo pacman -Syu
```

### 3. Install Essential Tools

```bash
sudo pacman -S git base-devel curl wget
```

### 4. Enable Multilib (Optional, for 32-bit support)

Edit `/etc/pacman.conf` and uncomment:
```ini
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Then run:
```bash
sudo pacman -Syy
```

---

## 📦 Core Installation

### Install Hyprland & Wayland Components

```bash
sudo pacman -S hyprland
sudo pacman -S xdg-desktop-portal-hyprland xdg-desktop-portal-wlr
sudo pacman -S polkit-gnome wl-clipboard wl-paste
```

### Install Waybar

```bash
sudo pacman -S waybar
```

### Install Optional Dependencies

```bash
# Terminal
sudo pacman -S alacritty kitty

# Launcher & Menu
sudo pacman -S rofi-wayland wofi

# File Manager
sudo pacman -S thunar ranger pcmanfm-gtk3

# Notifications
sudo pacman -S dunst

# Audio Control
sudo pacman -S pavucontrol alsa-utils pulseaudio-control

# Brightness Control
sudo pacman -S brightnessctl

# Wallpaper Engine
sudo pacman -S swww

# Network Manager
sudo pacman -S network-manager-applet

# Fonts
sudo pacman -S ttf-fira-code ttf-jetbrains-mono ttf-nerd-fonts-symbols noto-fonts noto-fonts-emoji

# Utilities
sudo pacman -S hyprpaper mpv vlc imagemagick
```

---

## 🔧 Configuration

### Directory Structure

```
~/.config/
├── hypr/
│   ├── hyprland.conf        # Main Hyprland config
│   ├── hyprlandrc           # Environment variables
│   └── keybinds.conf        # Keybindings (optional)
├── waybar/
│   ├── config               # Waybar modules & layout
│   └── style.css            # Waybar styling
├── dunst/
│   └── dunstrc              # Notification daemon
├── alacritty/
│   └── alacritty.toml       # Terminal config
└── rofi/
    └── config.rasi          # Launcher config
```

---

### 1. Hyprland Configuration

**~/.config/hypr/hyprland.conf** (Minimal Example):

```ini
# Monitor Setup
monitor = HDMI-1, 1920x1080@60, 0x0, 1
monitor = eDP-1, 1366x768@60, 1920x0, 1
workspace = 1, monitor:HDMI-1
workspace = 2, monitor:eDP-1

# Environment Variables
$terminal = alacritty
$launcher = wofi --show drun

# Autostart
exec-once = waybar &
exec-once = dunst &
exec-once = nm-applet &
exec-once = swww init &

# Input
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options = caps:escape
    kb_rules =
    follow_mouse = 1
    touchpad {
        natural_scroll = false
    }
    sensitivity = 0
}

# General
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
    allow_tearing = false
}

# Animations
animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 10, myBezier
    animation = windowsOut, 1, 10, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Keybinds
$mainMod = SUPER

bind = $mainMod, RETURN, exec, $terminal
bind = $mainMod, D, exec, $launcher
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, thunar
bind = $mainMod, F, fullscreen, 0
bind = $mainMod, V, togglefloating,

# Workspace Navigation
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3

# Movement
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Resize
bind = $mainMod SHIFT, left, resizeactive, -50 0
bind = $mainMod SHIFT, right, resizeactive, 50 0
```

See [Hyprland Wiki](https://wiki.hyprland.org/) for full documentation.

---

### 2. Waybar Configuration

**~/.config/waybar/config** (Example):

```json
{
  "layer": "top",
  "height": 30,
  "modules-left": ["hyprland/workspaces"],
  "modules-center": ["clock"],
  "modules-right": ["network", "battery", "pulseaudio", "tray"],
  
  "hyprland/workspaces": {
    "format": "{name}",
    "on-click": "activate"
  },
  "clock": {
    "format": "{:%H:%M | %a, %b %d}",
    "timezone": "UTC"
  },
  "network": {
    "format-wifi": "󰖩 {essid}",
    "format-disconnected": "󰖪 Disconnected",
    "interval": 10
  },
  "battery": {
    "format": "{capacity}% {icon}",
    "format-icons": ["󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂"]
  },
  "pulseaudio": {
    "format": "{volume}% 🔊",
    "format-muted": "🔇 Muted"
  }
}
```

**~/.config/waybar/style.css** (Example):

```css
* {
  border: none;
  border-radius: 0;
  font-family: "FiraCode Nerd Font";
  font-size: 13px;
  min-height: 0;
}

window#waybar {
  background: #1e1e2e;
  color: #cdd6f4;
  border-bottom: 1px solid #45475a;
}

#workspaces button {
  padding: 0 10px;
  color: #89b4fa;
  background: transparent;
}

#workspaces button.active {
  background: #45475a;
  border-bottom: 3px solid #89b4fa;
}

#clock, #network, #battery, #pulseaudio {
  padding: 0 10px;
}
```

See [Waybar Docs](https://github.com/Alexays/Waybar/wiki) for full options.

---

### 3. Dunst (Notifications)

**~/.config/dunst/dunstrc**:

```ini
[global]
monitor = 0
follow = mouse
geometry = "300x50-10+38"
indicate_hidden = yes
shrink = no
transparency = 10
separator_height = 2
padding = 8
horizontal_padding = 8
frame_width = 2
frame_color = "#89b4fa"
background = "#1e1e2e"
foreground = "#cdd6f4"
timeout = 10
```

---

## 🎯 Quick Start

1. **Boot into Hyprland**: After installation, select "Hyprland" from your login manager
2. **Open Terminal**: `Super + Enter`
3. **Launch Apps**: `Super + D`
4. **Edit Config**: `Super + Enter` → `vim ~/.config/hypr/hyprland.conf`

---

## 🎨 Theming & Customization

### Popular Color Schemes

- **Catppuccin** - Warm pastels
- **Dracula** - Dark & elegant
- **Nord** - Cool & professional
- **Gruvbox** - Retro & warm

### Recommended Theme Resources

- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [Awesome Hyprland Configs](https://github.com/hyprland-community/awesome-hyprland)
- [dotfiles.github.io](https://dotfiles.github.io/)

---

## 📚 Learning Resources

- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Arch Wiki: Hyprland](https://wiki.archlinux.org/title/Hyprland)
- [Waybar GitHub](https://github.com/Alexays/Waybar)
- [Wayland Documentation](https://wayland.freedesktop.org/)

---

## 🐛 Troubleshooting

### Hyprland won't start

```bash
# Check logs
cat ~/.local/share/hyprland/hyprlanderr.log
```

### Waybar not appearing

```bash
# Restart Waybar
killall waybar
waybar &
```

### GPU acceleration issues

- NVIDIA: Install `nvidia-utils` and set `WLR_NO_HARDWARE_CURSORS=1`
- AMD: Use `RADV` driver or `amdvlk`

---

## 🤝 Contributing

Feel free to share your configs, themes, or improvements!

---

## 📄 License

This repository is provided as-is for educational and personal use.

---

## ⭐ Show Your Support

If this guide helped you, consider starring the repo! 🌟

---

**Happy Tiling!** 🚀
