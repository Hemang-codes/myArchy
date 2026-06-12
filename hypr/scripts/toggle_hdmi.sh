#!/bin/bash
# 1. Identify your main screen name (run 'hyprctl monitors' to confirm)
MAIN_SCREEN="eDP-1"
EXTERNAL_SCREEN="HDMI-A-1"

# 2. Check if HDMI-A-1 is currently active
if hyprctl monitors | grep -q "$EXTERNAL_SCREEN"; then
  # Disable the HDMI monitor
  hyprctl keyword monitor "$EXTERNAL_SCREEN, disable"
else
  # Re-enable the HDMI monitor to the RIGHT of your laptop screen
  # Format: monitor = name, resolution, position, scale
  hyprctl keyword monitor "$EXTERNAL_SCREEN, 1600x900@60, 1600x0, 1"
fi
