#!/bin/bash

STATE_FILE="/tmp/sketchybar_monitor_count"

CURRENT=$(aerospace list-monitors | wc -l | xargs)

if [ ! -f "$STATE_FILE" ]; then
    echo "$CURRENT" > "$STATE_FILE"
    exit 0
fi

PREVIOUS=$(cat "$STATE_FILE")

if [ "$CURRENT" != "$PREVIOUS" ]; then
    echo "$CURRENT" > "$STATE_FILE"

    sleep 1
    sketchybar --reload
fi