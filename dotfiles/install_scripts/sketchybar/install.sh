#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_CONFIG_DIR="$SCRIPT_DIR/.config/sketchybar"
LOCAL_CONFIG_DIR="$HOME/.config/sketchybar"

# ── Install packages ──────────────────────────────────────────────────────────

echo ""
echo "Installing SketchyBar..."
brew tap FelixKratz/formulae
brew install sketchybar

echo ""
echo "Installing dependencies..."
brew install jq

echo ""
echo "Installing fonts and icons..."
brew install font-hack-nerd-font
brew install font-sf-pro
brew install --cask sf-symbols
brew install --cask font-sketchybar-app-font

# ── Config setup ──────────────────────────────────────────────────────────────

echo ""
echo "Choose configuration setup method for sketchybar:"
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

# ── Permissions ───────────────────────────────────────────────────────────────

FILES=$(find "$REPO_CONFIG_DIR" \( -name "*.sh" -o -name "*.py" \) -type f 2>/dev/null || true)

if [ -n "$FILES" ]; then
    echo ""
    echo "Making scripts executable in sketchybar config..."

    while IFS= read -r file
    do
        chmod +x "$file"
        echo "  chmod +x $file"
    done <<< "$FILES"
fi

# ── Start SketchyBar ──────────────────────────────────────────────────────────

echo ""
read -rp "Do you want to start SketchyBar now? (y/n): " start_choice

if [[ "$start_choice" =~ ^[Yy]$ ]]; then
echo "Starting SketchyBar..."

```
brew services start sketchybar

# Give the service a moment to start
sleep 2

sketchybar --reload || true
```

else
echo ""
echo "You can start SketchyBar manually with:"
echo "  brew services start sketchybar"
echo ""
echo "And reload the configuration with:"
echo "  sketchybar --reload"
fi

echo ""
echo "SketchyBar installation complete."
