#!/bin/bash
# Install AI tools: claude-code, opencode

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing AI tools..."

# claude-code
if is_installed claude; then
    echo -e "${YELLOW}[SKIP]${NC} claude-code already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} claude-code"
    yay -S --noconfirm claude-code
fi

# opencode
if is_installed opencode; then
    echo -e "${YELLOW}[SKIP]${NC} opencode already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} opencode"
    yay -S --noconfirm opencode-bin
fi

echo "AI tools installation complete!"
