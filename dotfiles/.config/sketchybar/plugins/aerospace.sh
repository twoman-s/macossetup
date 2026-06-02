# #!/bin/bash

# CURRENT=$(aerospace list-workspaces --monitor focused)

# if [ "$1" = "$CURRENT" ]; then
#     sketchybar --set "$NAME" background.drawing=on
# else
#     sketchybar --set "$NAME" background.drawing=off
# fi


# #!/bin/bash

# CURRENT=$(aerospace list-workspaces --focused)

# sketchybar --set aerospace_workspace \
#   label="$CURRENT"

# #!/bin/bash

# CURRENT=$(aerospace list-workspaces --focused)

# if [ "$1" = "$CURRENT" ]; then
#     sketchybar --set "$NAME" \
#         background.drawing=on
# else
#     sketchybar --set "$NAME" \
#         background.drawing=off
# fi

# #!/bin/bash

# CURRENT=$(aerospace list-workspaces --focused)

# if [ "$1" = "$CURRENT" ]; then
#     sketchybar --set "$NAME" \
#         background.drawing=on
# else
#     sketchybar --set "$NAME" \
#         background.drawing=off
# fi


#!/bin/bash

CURRENT=$(aerospace list-workspaces --focused)
MONITOR_COUNT=$(aerospace list-monitors | wc -l | xargs)

if [ "$MONITOR_COUNT" -eq 1 ]; then

    sketchybar --set aerospace_workspace \
        label="$CURRENT"

else

    if [ "$1" = "$CURRENT" ]; then
        sketchybar --set "$NAME" \
            background.drawing=on
    else
        sketchybar --set "$NAME" \
            background.drawing=off
    fi

fi