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
# Copy aerospace config
# -----------------------------
echo ""
echo "Copying AeroSpace config..."

mkdir -p ~/.config/aerospace

cp -R ./.config/aerospace/* ~/.config/aerospace/

echo ""
echo "======================================"
echo " Setup Complete!"
echo "======================================"

echo ""
echo "Start AeroSpace manually once:"
echo "open -a AeroSpace"