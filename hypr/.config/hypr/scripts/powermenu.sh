#!/bin/bash
choice=$(echo -e "Lock\nLogout\nSuspend\nReboot\nShutdown" | rofi -dmenu -p "Power Menu")
case $choice in
Lock) hyprlock ;; # Or swaylock
Logout) hyprctl dispatch exit ;;
Suspend) systemctl suspend ;;
Reboot) systemctl reboot ;;
Shutdown) systemctl poweroff ;;
esac
