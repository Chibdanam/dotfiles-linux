#!/bin/bash
# Install dev core: cmake, python, docker

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing dev core tools..."

# cmake
if is_installed cmake; then
    echo -e "${YELLOW}[SKIP]${NC} cmake already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} cmake"
    sudo pacman -S --noconfirm cmake
fi

# python3 and pip
if is_installed python3; then
    echo -e "${YELLOW}[SKIP]${NC} python already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} python"
    sudo pacman -S --noconfirm python python-pip
fi

# docker
if is_installed docker; then
    echo -e "${YELLOW}[SKIP]${NC} docker already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} docker"
    sudo pacman -S --noconfirm docker
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
    sudo usermod -aG docker "$USER"
    echo "Note: Log out and back in for docker group to take effect"
fi

echo "Dev core tools installation complete!"
