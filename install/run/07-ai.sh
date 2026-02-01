#!/bin/bash
# Install AI tools: claude-code, opencode

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing AI tools..."

# claude-code
if is_installed claude; then
    echo -e "${YELLOW}[SKIP]${NC} claude-code already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} claude-code"
    yay -Syu --noconfirm claude-code
fi

# opencode
if is_installed opencode; then
    echo -e "${YELLOW}[SKIP]${NC} opencode already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} opencode"
    yay -Syu --noconfirm opencode-bin
fi

echo "AI tools installation complete!"
