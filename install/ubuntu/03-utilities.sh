#!/bin/bash
# Install utilities via apt: tmux, unzip, fastfetch
# Note: bat, eza, fzf, ripgrep, fd, zoxide, bottom, sd, delta are installed via mise in 01-prerequisites.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing utilities..."

# tmux
if is_installed tmux; then
    echo -e "${YELLOW}[SKIP]${NC} tmux already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} tmux"
    sudo apt update
    sudo apt install -y tmux
fi

# unzip
if is_installed unzip; then
    echo -e "${YELLOW}[SKIP]${NC} unzip already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} unzip"
    sudo apt update
    sudo apt install -y unzip
fi

# fastfetch
if is_installed fastfetch; then
    echo -e "${YELLOW}[SKIP]${NC} fastfetch already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} fastfetch"
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
    sudo apt update
    sudo apt install -y fastfetch
fi

echo "Utilities installation complete!"
