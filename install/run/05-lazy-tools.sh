#!/bin/bash
# Install lazy tools: lazydocker, lazygit, lazysql, yazi

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing lazy tools..."

# lazydocker
if is_installed lazydocker; then
    echo -e "${YELLOW}[SKIP]${NC} lazydocker already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} lazydocker"
    yay -Syu --noconfirm lazydocker
fi

# lazygit
if is_installed lazygit; then
    echo -e "${YELLOW}[SKIP]${NC} lazygit already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} lazygit"
    yay -Syu --noconfirm lazygit
fi

# lazysql
if is_installed lazysql; then
    echo -e "${YELLOW}[SKIP]${NC} lazysql already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} lazysql"
    yay -Syu --noconfirm lazysql
fi

# yazi
if is_installed yazi; then
    echo -e "${YELLOW}[SKIP]${NC} yazi already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} yazi"
    yay -Syu --noconfirm yazi
fi

echo "Lazy tools installation complete!"
