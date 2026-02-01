#!/bin/bash
# Install misc tools: ansible, xleak

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing misc tools..."

# ansible
if is_installed ansible; then
    echo -e "${YELLOW}[SKIP]${NC} ansible already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} ansible"
    yay -Syu --noconfirm ansible
fi

# xleak
if is_installed xleak; then
    echo -e "${YELLOW}[SKIP]${NC} xleak already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} xleak"
    yay -Syu --noconfirm xleak-bin
fi

echo "Misc tools installation complete!"
