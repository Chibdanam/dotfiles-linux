#!/bin/bash
# Install utilities: bat, btop, eza, tldr, fastfetch, fzf, unzip, zoxide

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing utilities..."

# unzip
if is_installed unzip; then
    echo -e "${YELLOW}[SKIP]${NC} unzip already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} unzip"
    yay -Syu --noconfirm unzip
fi

# bat
if is_installed bat; then
    echo -e "${YELLOW}[SKIP]${NC} bat already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} bat"
    yay -Syu --noconfirm bat
fi

# btop
if is_installed btop; then
    echo -e "${YELLOW}[SKIP]${NC} btop already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} btop"
    yay -Syu --noconfirm btop
fi

# fzf
if is_installed fzf; then
    echo -e "${YELLOW}[SKIP]${NC} fzf already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} fzf"
    yay -Syu --noconfirm fzf
fi

# tldr
if is_installed tldr; then
    echo -e "${YELLOW}[SKIP]${NC} tldr already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} tldr"
    yay -Syu --noconfirm tldr
fi

# eza
if is_installed eza; then
    echo -e "${YELLOW}[SKIP]${NC} eza already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} eza"
    yay -Syu --noconfirm eza
fi

# fastfetch
if is_installed fastfetch; then
    echo -e "${YELLOW}[SKIP]${NC} fastfetch already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} fastfetch"
    yay -Syu --noconfirm fastfetch
fi

# zoxide
if is_installed zoxide; then
    echo -e "${YELLOW}[SKIP]${NC} zoxide already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} zoxide"
    yay -Syu --noconfirm zoxide
fi

echo "Utilities installation complete!"
