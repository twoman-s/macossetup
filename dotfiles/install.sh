#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPTS_DIR="$SCRIPT_DIR/install_scripts"

echo "======================================"
echo "   Mac Setup Installer"
echo "======================================"

# Make helper scripts executable
chmod +x "$INSTALL_SCRIPTS_DIR"/*.sh

# Run scripts
"$INSTALL_SCRIPTS_DIR/check_homebrew.sh"
"$INSTALL_SCRIPTS_DIR/install_packages.sh"
"$INSTALL_SCRIPTS_DIR/setup_config.sh"
"$INSTALL_SCRIPTS_DIR/setup_permissions.sh"
"$INSTALL_SCRIPTS_DIR/start_aerospace.sh"

echo ""
echo "======================================"
echo " Setup Finished!"
echo "======================================"