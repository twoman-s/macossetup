#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

REPO_CONFIG_DIR="$SCRIPT_DIR/.config"
LOCAL_CONFIG_DIR="$HOME/.config"

mkdir -p "$LOCAL_CONFIG_DIR"

echo ""
echo "Choose configuration setup method:"
echo ""
echo "1) Create symlinks"
echo "2) Copy files"
echo ""

read -p "Enter choice (1 or 2): " choice

if [ "$choice" = "1" ]; then

    echo ""
    echo "Creating symlinks..."

    for item in "$REPO_CONFIG_DIR"/*; do

        name=$(basename "$item")
        target="$LOCAL_CONFIG_DIR/$name"

        rm -rf "$target"

        ln -s "$item" "$target"

        echo "Linked:"
        echo "$target -> $item"
        echo ""

    done

elif [ "$choice" = "2" ]; then

    echo ""
    echo "Copying files..."

    cp -R "$REPO_CONFIG_DIR"/* "$LOCAL_CONFIG_DIR"/

    echo ""
    echo "Files copied."

else

    echo ""
    echo "Invalid choice."
    exit 1

fi