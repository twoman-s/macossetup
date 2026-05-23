#!/bin/bash

LOG_FILE="$HOME/.config/aerospace/vscode-workspace.log"

echo "==================================" >> "$LOG_FILE"
echo "Script triggered at: $(date)" >> "$LOG_FILE"

# Count VSCode windows
COUNT=$(aerospace list-windows --all | grep "| Code " | wc -l)

echo "VSCode window count: $COUNT" >> "$LOG_FILE"

# Debug window list
echo "" >> "$LOG_FILE"
echo "All windows:" >> "$LOG_FILE"
aerospace list-windows --all >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# Only continue if more than one VSCode window exists
if [ "$COUNT" -gt 1 ]; then

    echo "More than one VSCode window detected." >> "$LOG_FILE"
    echo "Moving focused window to workspace B..." >> "$LOG_FILE"

    aerospace move-node-to-workspace B >> "$LOG_FILE" 2>&1

    echo "Move command executed." >> "$LOG_FILE"

else

    echo "Not enough VSCode windows. No action taken." >> "$LOG_FILE"

fi

echo "Script finished." >> "$LOG_FILE"
echo "" >> "$LOG_FILE"