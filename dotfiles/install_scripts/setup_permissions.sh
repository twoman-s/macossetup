#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_DIR="$SCRIPT_DIR/.config"

echo ""
echo "======================================"
echo " Executable Permission Setup"
echo "======================================"
echo ""

# Find only .sh and .py files inside .config
FILES=$(find "$CONFIG_DIR" \
    \( -name "*.sh" -o -name "*.py" \) \
    -type f)

# Check if any files were found
if [ -z "$FILES" ]; then
    echo "No executable files found inside .config"
    exit 0
fi

echo "The following files will be made executable:"
echo ""

echo "$FILES"

echo ""
read -p "Continue? (y/n): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Permission setup cancelled."
    exit 1
fi

echo ""

for file in $FILES; do
    chmod +x "$file"

    echo "Made executable:"
    echo "$file"
    echo ""
done

echo "Executable permissions updated successfully."