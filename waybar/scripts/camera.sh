#!/bin/bash
if fuser /dev/video0 >/dev/null 2>&1; then
  # Shows the camera icon AND a small dot
  echo '{"text": "◉", "class": "active"}'
else
  # Shows just the camera icon when off
  echo '{"text": " ", "class": "active"}'
fi
