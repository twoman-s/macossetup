#!/bin/bash

sketchybar --add event display_change
sketchybar --add item display_watcher left \
  --set display_watcher drawing=off \
  script="$PLUGIN_DIR/display_change.sh" \
  --subscribe display_watcher display_change