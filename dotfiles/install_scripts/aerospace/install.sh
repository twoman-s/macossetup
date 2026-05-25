#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_CONFIG_DIR="$SCRIPT_DIR/.config/aerospace"
LOCAL_CONFIG_DIR="$HOME/.config/aerospace"

# ── Install packages ──────────────────────────────────────────────────────────

echo ""
echo "Installing AeroSpace..."
brew install --cask nikitabobko/tap/aerospace

echo ""
echo "Installing Borders..."
brew tap FelixKratz/formulae
brew install borders

# ── Config setup ──────────────────────────────────────────────────────────────

echo ""
echo "Choose configuration setup method for aerospace:"
echo "  1) Create symlink (recommended — changes in the repo reflect immediately)"
echo "  2) Copy files"
echo ""
read -rp "Enter choice (1 or 2): " choice

mkdir -p "$HOME/.config"

if [ "$choice" = "1" ]; then
    rm -rf "$LOCAL_CONFIG_DIR"
    ln -s "$REPO_CONFIG_DIR" "$LOCAL_CONFIG_DIR"
    echo ""
    echo "Linked: $LOCAL_CONFIG_DIR -> $REPO_CONFIG_DIR"
elif [ "$choice" = "2" ]; then
    mkdir -p "$LOCAL_CONFIG_DIR"
    cp -R "$REPO_CONFIG_DIR"/* "$LOCAL_CONFIG_DIR"/
    echo ""
    echo "Files copied to $LOCAL_CONFIG_DIR"
else
    echo ""
    echo "Invalid choice. Skipping config setup."
fi

# ── Permissions ───────────────────────────────────────────────────────────────

FILES=$(find "$REPO_CONFIG_DIR" \( -name "*.sh" -o -name "*.py" \) -type f 2>/dev/null || true)
if [ -n "$FILES" ]; then
    echo ""
    echo "Making scripts executable in aerospace config..."
    while IFS= read -r file; do
        chmod +x "$file"
        echo "  chmod +x $file"
    done <<< "$FILES"
fi

# ── Start AeroSpace ───────────────────────────────────────────────────────────

echo ""
read -rp "Do you want to start AeroSpace now? (y/n): " start_choice
if [[ "$start_choice" =~ ^[Yy]$ ]]; then
    echo "Starting AeroSpace..."
    open -a AeroSpace
else
    echo ""
    echo "You can start AeroSpace manually with:"
    echo "  open -a AeroSpace"
fi
