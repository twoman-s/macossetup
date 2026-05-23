#!/bin/bash

set -e

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