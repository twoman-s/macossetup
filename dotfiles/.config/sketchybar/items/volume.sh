#!/bin/bash

sketchybar --add item volume right \
    --set volume \
    icon=􀫦\
    script="$CONFIG_DIR/plugins/volume.sh" \
    --subscribe volume volume_change \