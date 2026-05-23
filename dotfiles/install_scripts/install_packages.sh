#!/bin/bash

set -e

echo ""
echo "Installing AeroSpace..."
brew install --cask nikitabobko/tap/aerospace

echo ""
echo "Installing Borders..."
brew tap FelixKratz/formulae
brew install borders