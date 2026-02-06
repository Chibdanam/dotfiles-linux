#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$SCRIPT_DIR/.gitconfig" ~/.gitconfig
echo "Synced .gitconfig to ~/.gitconfig"
