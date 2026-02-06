#!/bin/bash
# Install dev core: cmake, python, docker
# Note: neovim is installed via mise, build-essential is in 01-prerequisites.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing dev core tools..."

# cmake
if is_installed cmake; then
    echo -e "${YELLOW}[SKIP]${NC} cmake already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} cmake"
    sudo apt update
    sudo apt install -y cmake
fi

# python3 and pip
if is_installed python3; then
    echo -e "${YELLOW}[SKIP]${NC} python3 already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} python3"
    sudo apt install -y python3 python3-pip python3-venv
fi

# docker
if is_installed docker; then
    echo -e "${YELLOW}[SKIP]${NC} docker already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} docker"
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "$USER"
    echo "Note: Log out and back in for docker group to take effect"
fi

echo "Dev core tools installation complete!"
