#!/bin/bash
# Install utilities: tmux, unzip (system packages), everything else via mise

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing utilities..."

# System packages (these need to be installed via package manager)
pkg_install tmux
pkg_install unzip

# All other CLI utilities are managed by mise (see mise/config.toml):
#   ripgrep, bat, eza, fd, sd, fzf, zoxide, bottom, delta, fastfetch
echo -e "${YELLOW}[INFO]${NC} CLI utilities (ripgrep, bat, eza, fd, sd, fzf, zoxide, bottom, delta, fastfetch) provided by mise"

echo "Utilities installation complete!"
