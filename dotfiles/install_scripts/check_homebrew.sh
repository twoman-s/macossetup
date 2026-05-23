#!/bin/bash

set -e

echo ""
echo "Checking Homebrew..."

if ! command -v brew &> /dev/null
then
    echo ""
    echo "Homebrew is not installed."
    echo "Please install Homebrew manually first:"
    echo "https://brew.sh"
    echo ""
    exit 1
fi

echo "Homebrew found."