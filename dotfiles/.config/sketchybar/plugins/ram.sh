#!/bin/bash

TOTAL_BYTES=$(sysctl -n hw.memsize)

USED_PERCENT=$(memory_pressure | awk '/System-wide memory free percentage/ {gsub("%","",$5); print 100-$5}')

USED_BYTES=$(echo "$TOTAL_BYTES * $USED_PERCENT / 100" | bc)

USED_GB=$(echo "scale=1; $USED_BYTES / 1024 / 1024 / 1024" | bc)
TOTAL_GB=$(echo "scale=1; $TOTAL_BYTES / 1024 / 1024 / 1024" | bc)

sketchybar --set "$NAME" label="${USED_GB}/${TOTAL_GB}GB"