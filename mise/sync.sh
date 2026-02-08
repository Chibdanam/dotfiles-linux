#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p ~/.config/mise
ln -sf "$(readlink -f "$SCRIPT_DIR/config.toml")" ~/.config/mise/config.toml
echo "Synced mise config to ~/.config/mise/config.toml"
