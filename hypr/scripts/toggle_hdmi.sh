#!/bin/bash

STATE_FILE="/tmp/hdmi_monitor_state"

if [ ! -f "$STATE_FILE" ] || [ "$(cat "$STATE_FILE")" = "disabled" ]; then
  hyprctl keyword monitor HDMI-A-1,1600x900@60,auto-left,1
  echo "enabled" >"$STATE_FILE"
else
  hyprctl keyword monitor HDMI-A-1,disable
  echo "disabled" >"$STATE_FILE"
fi
