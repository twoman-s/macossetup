#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
REPO_CONFIG_DIR="$SCRIPT_DIR/.config/gh-dash"
LOCAL_CONFIG_DIR="$HOME/.config/gh-dash"

# ── Install packages ──────────────────────────────────────────────────────────

echo ""
echo "Installing GitHub CLI (gh)..."
brew install gh

echo ""
echo "Installing delta (git diff viewer)..."
brew install git-delta


# ── GitHub Authentication ─────────────────────────────────────────────────────

echo ""
echo "======================================"
echo " GitHub Authentication"
echo "======================================"
echo ""
echo "gh-dash requires you to be logged into the GitHub CLI."
read -rp "Login to GitHub now? (y/n): " login_choice
if [[ "$login_choice" =~ ^[Yy]$ ]]; then
    gh auth login
    echo ""
    echo "Installing gh-dash..."
    # brew tap dlvhdr/gh-dash
    gh extension install dlvhdr/gh-dash
else
    echo ""
    echo "You can login later with: gh auth login"
fi

# ── Config setup ──────────────────────────────────────────────────────────────

echo ""
echo "Choose configuration setup method for gh-dash:"
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
    echo "Making scripts executable in gh-dash config..."
    while IFS= read -r file; do
        chmod +x "$file"
        echo "  chmod +x $file"
    done <<< "$FILES"
fi

# ── Post-install note ─────────────────────────────────────────────────────────

echo ""
echo "======================================"
echo " Post-Installation Step"
echo "======================================"
echo ""
echo "Run this command manually to install the gh-dash extension: if not logged in to gh during installation, it may have been skipped."
echo ""
echo "  gh extension install dlvhdr/gh-dash"
echo ""
