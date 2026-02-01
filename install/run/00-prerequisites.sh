#!/bin/bash
# Install prerequisites: yay, mise, Go, Rust

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing prerequisites..."

# Update system first
echo -e "${GREEN}[UPDATE]${NC} Updating system packages"
sudo pacman -Syu --noconfirm

# Base development tools
if pacman -Qi base-devel &> /dev/null; then
    echo -e "${YELLOW}[SKIP]${NC} base-devel already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} base-devel"
    sudo pacman -Syu --noconfirm --needed base-devel
fi

# git
if is_installed git; then
    echo -e "${YELLOW}[SKIP]${NC} git already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} git"
    sudo pacman -Syu --noconfirm git
fi

# Go
if is_installed go; then
    echo -e "${YELLOW}[SKIP]${NC} Go already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} Go"
    sudo pacman -Syu --noconfirm go
fi

# Rust
if is_installed cargo; then
    echo -e "${YELLOW}[SKIP]${NC} Rust already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} Rust"
    sudo pacman -Syu --noconfirm rust
fi

# yay
if is_installed yay; then
    echo -e "${YELLOW}[SKIP]${NC} yay already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} yay"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# mise
if is_installed mise; then
    echo -e "${YELLOW}[SKIP]${NC} mise already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} mise"
    yay -Syu --noconfirm mise
fi

echo "Prerequisites installation complete!"
