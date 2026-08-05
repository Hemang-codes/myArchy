# 🪟 My Arch Linux Rice

A minimal, cozy, and highly functional Arch Linux configuration featuring a warm anime/Ghibli-inspired aesthetic, custom top status bar, and optimized workspace management.

## 📸 Preview

<p align="center">
  <img src="preview.png" alt="Setup Preview 1" width="48%" />
  <img src="preview1.png" alt="Setup Preview 2" width="48%" />
</p>
<p align="center"><em>Current setup showcasing the clean top bar, active workspace indicators, and system resource monitors.</em></p>

---

## ✨ Features

- **Minimalist Aesthetic:** Soft, warm color palette with clean typography.
- **Custom Status Bar:** Center-aligned clock, left-aligned workspace switcher, and right-aligned system telemetry (CPU temperature, battery life, connectivity).
- **Dynamic Workspaces:** Optimized layout switching for seamless multitasking.
- **Lightweight Performance:** Built for speed and low RAM utilization at idle.

---

## 🛠️ Tech Stack & Components

- **OS:** Arch Linux
- **WM / DE:** Hyprland / i3wm / Sway *(Choose yours)*
- **Status Bar:** Waybar / Polybar *(Choose yours)*
- **Terminal:** Alacritty / Kitty *(Choose yours)*

---

## 🚀 Installation

### 1. Prerequisites
Ensure you have the required packages installed on your system:
```bash
sudo pacman -S git base-devel
```

### 2. Clone the Repository
Clone this repository directly into your home or configuration directory:
```bash
git clone https://github.com
```

### 3. Apply Configuration
Symlink or copy the configuration files to your system config folder:
```bash
ln -s ~/.config/dotfiles/your_wm ~/.config/your_wm
```

---

## ⌨️ Keybindings (Quick Reference)

| Action | Keybinding |
| :--- | :--- |
| **Open Terminal** | `SUPER` + `Return` |
| **App Launcher** | `SUPER` + `SPACE` |
| **Close Window** | `SUPER` + `W` |
| **Switch Workspaces** | `SUPER` + `1-5` |
