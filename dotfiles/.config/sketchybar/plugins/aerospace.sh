#!/bin/bash
source "$CONFIG_DIR/scripts/colors.sh"


CURRENT=$(aerospace list-workspaces --focused)
MONITOR_COUNT=$(aerospace list-monitors | wc -l | xargs)


if [ "$MONITOR_COUNT" -eq 1 ]; then

    ICON_STRIP=""

    while read -r APP; do
        [ -z "$APP" ] && continue

        ICON="$($CONFIG_DIR/plugins/icon_map_fn.sh "$APP")"

        if [ -n "$ICON" ]; then
            ICON_STRIP+=" $ICON"
        fi

    done < <(
        aerospace list-windows \
            --workspace "$CURRENT" \
            --format '%{app-name}' \
            | sort -u
    )

    [ -z "$ICON_STRIP" ] && ICON_STRIP=" —"

    sketchybar --set aerospace_workspace \
        icon="$CURRENT" \
        label="$ICON_STRIP"

else

    if [ "$1" = "$CURRENT" ]; then
        sketchybar --set "$NAME" \
            background.drawing=on \
            background.color=$ITEM_BG_COLOR
    fi

    ICON_STRIP=""

    while read -r APP; do
        [ -z "$APP" ] && continue

        ICON="$($CONFIG_DIR/plugins/icon_map_fn.sh "$APP")"

        if [ -n "$ICON" ]; then
            ICON_STRIP+=" $ICON"
        fi

    done < <(
        aerospace list-windows \
            --workspace "$1" \
            --format '%{app-name}' \
            | sort -u
    )

    [ -z "$ICON_STRIP" ] && ICON_STRIP=""

    sketchybar --set "$NAME" \
        label="$ICON_STRIP"

fi