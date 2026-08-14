sketchybar --add item network_speed q \
    --set network_speed \
        update_freq=1 \
        icon.drawing=off \
        label.font="SF Pro:Regular:13.0" \
        label.padding_left=8 \
        label.padding_right=8 \
        background.drawing=on \
        background.corner_radius=6 \
        background.height=26 \
        script="$PLUGIN_DIR/network_speed.sh"