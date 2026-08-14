#!/bin/bash

# Get the interface currently used for the default route
INTERFACE=$(route -n get default 2>/dev/null | awk '/interface:/{print $2}')

if [ -z "$INTERFACE" ]; then
    sketchybar --set "$NAME" label="↓ --  ↑ --"
    exit 0
fi

# Get received/transmitted bytes
read RX TX <<< $(netstat -ib | awk -v iface="$INTERFACE" '
    $1 == iface && $7 ~ /^[0-9]+$/ && $10 ~ /^[0-9]+$/ {
        rx += $7
        tx += $10
    }
    END {
        print rx, tx
    }
')

# Store previous values
CACHE="/tmp/sketchybar_network_speed"

if [ -f "$CACHE" ]; then
    read OLD_RX OLD_TX OLD_TIME < "$CACHE"

    NOW=$(date +%s)
    ELAPSED=$((NOW - OLD_TIME))

    if [ "$ELAPSED" -gt 0 ]; then
        RX_SPEED=$(( (RX - OLD_RX) / ELAPSED ))
        TX_SPEED=$(( (TX - OLD_TX) / ELAPSED ))
    else
        RX_SPEED=0
        TX_SPEED=0
    fi
else
    RX_SPEED=0
    TX_SPEED=0
    NOW=$(date +%s)
fi

echo "$RX $TX $(date +%s)" > "$CACHE"

format_speed() {
    local SPEED=$1

    if [ "$SPEED" -ge 1048576 ]; then
        awk "BEGIN {printf \"%.1fM\", $SPEED / 1048576}"
    elif [ "$SPEED" -ge 1024 ]; then
        awk "BEGIN {printf \"%.0fK\", $SPEED / 1024}"
    else
        echo "${SPEED}B"
    fi
}

RX_FORMATTED=$(format_speed "$RX_SPEED")
TX_FORMATTED=$(format_speed "$TX_SPEED")

sketchybar --set "$NAME" label="↓ $RX_FORMATTED  ↑ $TX_FORMATTED"