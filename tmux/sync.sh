#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
echo "Synced .tmux.conf to ~/.tmux.conf"
echo "Install plugins: press prefix (Ctrl-A) + I inside tmux"
