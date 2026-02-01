#!/bin/bash
# Install dev core: cmake, python, docker, neovim, mingw-w64, libx11

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing dev core tools..."

# cmake
if is_installed cmake; then
    echo -e "${YELLOW}[SKIP]${NC} cmake already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} cmake"
    yay -Syu --noconfirm cmake
fi

# python3 and pip
if is_installed python3; then
    echo -e "${YELLOW}[SKIP]${NC} python already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} python"
    yay -Syu --noconfirm python python-pip
fi

# docker
if is_installed docker; then
    echo -e "${YELLOW}[SKIP]${NC} docker already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} docker"
    yay -Syu --noconfirm docker
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
    sudo usermod -aG docker "$USER"
    echo "Note: Log out and back in for docker group to take effect"
fi

# neovim
if is_installed nvim; then
    echo -e "${YELLOW}[SKIP]${NC} neovim already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} neovim"
    yay -Syu --noconfirm neovim
fi

# mingw-w64 (cross-compilation for Windows)
if is_installed x86_64-w64-mingw32-gcc; then
    echo -e "${YELLOW}[SKIP]${NC} mingw-w64-gcc already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} mingw-w64-gcc"
    yay -Syu --noconfirm mingw-w64-gcc
fi

# libx11 (X11 development libraries)
if pacman -Qi libx11 &> /dev/null; then
    echo -e "${YELLOW}[SKIP]${NC} libx11 already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} libx11"
    yay -Syu --noconfirm libx11
fi

echo "Dev core tools installation complete!"
