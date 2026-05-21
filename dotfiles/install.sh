#!/bin/bash

set -e

echo "======================================"
echo "   Mac Setup Installer"
echo "======================================"

# -----------------------------
# Check Homebrew
# -----------------------------
if ! command -v brew &> /dev/null
then
    echo ""
    echo "Homebrew is not installed."
    echo "Please install Homebrew manually first:"
    echo "https://brew.sh"
    echo ""
    exit 1
fi

# -----------------------------
# Install packages
# -----------------------------
echo ""
echo "Installing AeroSpace..."
brew install --cask nikitabobko/tap/aerospace

echo ""
echo "Installing Borders..."
brew tap FelixKratz/formulae
brew install borders

# -----------------------------
# Create ~/.config if missing
# -----------------------------
echo ""
echo "Creating ~/.config directory..."
mkdir -p ~/.config

# -----------------------------
# Setup selection
# -----------------------------
echo ""
echo "Choose configuration setup method:"
echo ""
echo "1) Create symlink"
echo "   - Edits reflect in both repo and config"
echo "   - Recommended for dotfiles management"
echo ""
echo "2) Copy files"
echo "   - Repo and config become separate files"
echo "   - Editing one will NOT update the other"
echo ""

read -p "Enter choice (1 or 2): " choice

# -----------------------------
# AeroSpace config setup
# -----------------------------
mkdir -p ~/.config/aerospace

REPO_PATH="$(pwd)/.config/aerospace/aerospace.toml"
CONFIG_PATH="$HOME/.config/aerospace/aerospace.toml"

if [ "$choice" = "1" ]; then

    echo ""
    echo "Creating symlink..."
    echo ""

    # Remove existing config if present
    rm -f "$CONFIG_PATH"

    ln -s "$REPO_PATH" "$CONFIG_PATH"

    echo ""
    echo "Symlink created:"
    echo "$CONFIG_PATH -> $REPO_PATH"

elif [ "$choice" = "2" ]; then

    echo ""
    echo "Copying config files..."
    echo ""

    cp -R ./.config/aerospace/* ~/.config/aerospace/

    echo ""
    echo "Files copied successfully."

else
    echo ""
    echo "Invalid choice."
    exit 1
fi

echo ""
echo "======================================"
echo " Setup Complete!"
echo "======================================"

# -----------------------------
# Start AeroSpace
# -----------------------------
echo ""
read -p "Do you want to start AeroSpace now? (y/n): " start_choice

if [[ "$start_choice" =~ ^[Yy]$ ]]; then

    echo ""
    echo "Starting AeroSpace..."

    open -a AeroSpace

else

    echo ""
    echo "You can start AeroSpace manually using:"
    echo ""
    echo "open -a AeroSpace"

fi