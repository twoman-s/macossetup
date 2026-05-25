#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPTS_DIR="$SCRIPT_DIR/install_scripts"
CONFIG_DIR="$SCRIPT_DIR/.config"

echo "======================================"
echo "   Mac Setup Installer"
echo "======================================"

# Make top-level helper scripts executable
find "$INSTALL_SCRIPTS_DIR" -maxdepth 1 -name "*.sh" -exec chmod +x {} \;

# Check Homebrew (always required)
"$INSTALL_SCRIPTS_DIR/check_homebrew.sh"

# Discover available configs from .config folder
configs=()
while IFS= read -r dir; do
    configs+=("$(basename "$dir")")
done < <(find "$CONFIG_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

if [ ${#configs[@]} -eq 0 ]; then
    echo ""
    echo "No configurations found in .config/"
    exit 1
fi

echo ""
echo "======================================"
echo " Available Configurations"
echo "======================================"
echo ""

for i in "${!configs[@]}"; do
    echo "  [$((i+1))] ${configs[$i]}"
done

echo ""
echo "Enter numbers to install (space-separated, e.g. \"1 2\"), or 'a' to install all:"
read -rp "> " selections

# Parse selections
selected=()
if [[ "$selections" =~ ^[Aa]$ ]]; then
    selected=("${configs[@]}")
else
    for num in $selections; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#configs[@]}" ]; then
            selected+=("${configs[$((num-1))]}")
        else
            echo "Warning: '$num' is not a valid selection (skipped)"
        fi
    done
fi

if [ ${#selected[@]} -eq 0 ]; then
    echo ""
    echo "No valid selections made. Exiting."
    exit 0
fi

echo ""
echo "The following will be installed:"
for s in "${selected[@]}"; do
    echo "  - $s"
done
echo ""

# Run installer for each selected config
for config in "${selected[@]}"; do
    installer="$INSTALL_SCRIPTS_DIR/$config/install.sh"
    if [ -f "$installer" ]; then
        echo "======================================"
        echo " Installing: $config"
        echo "======================================"
        chmod +x "$installer"
        "$installer"
    else
        echo ""
        echo "WARNING: No installer found for '$config'"
        echo "Expected: $installer"
        echo ""
    fi
done

echo ""
echo "======================================"
echo " Setup Finished!"
echo "======================================"