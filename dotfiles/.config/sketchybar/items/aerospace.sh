#!/bin/bash

sketchybar --add event aerospace_workspace_change

MONITOR_COUNT=$(aerospace list-monitors | wc -l | xargs)

if [ "$MONITOR_COUNT" -eq 1 ]; then

    sketchybar --add item aerospace_workspace left \
        --set aerospace_workspace \
            background.color=$ITEM_BG_COLOR \
            background.corner_radius=5 \
            background.height=20 \
            label="" \
            script="$CONFIG_DIR/plugins/aerospace.sh" \
        --subscribe aerospace_workspace aerospace_workspace_change

else

    while read -r WS DISPLAY; do
        sketchybar --add item "space.$WS" left \
            --set "space.$WS" \
                associated_display="$DISPLAY" \
                background.color=$ITEM_BG_COLOR \
                background.corner_radius=5 \
                background.height=20 \
                background.drawing=off \
                label="$WS" \
                click_script="aerospace workspace $WS" \
                script="$CONFIG_DIR/plugins/aerospace.sh $WS" \
            --subscribe "space.$WS" aerospace_workspace_change

    done < <(
        aerospace list-workspaces --all \
            --format "%{workspace} %{monitor-appkit-nsscreen-screens-id}"
    )

fi

sketchybar --trigger aerospace_workspace_change