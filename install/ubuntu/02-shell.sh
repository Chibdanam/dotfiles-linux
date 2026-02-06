#!/bin/bash
# Install shell tools: zsh
# Note: git is in 01-prerequisites.sh. git-delta and starship are installed via mise.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing shell tools..."

# zsh
if is_installed zsh; then
    echo -e "${YELLOW}[SKIP]${NC} zsh already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} zsh"
    sudo apt update
    sudo apt install -y zsh
fi

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${GREEN}[CONFIG]${NC} Setting zsh as default shell"
    sudo chsh -s "$(which zsh)" "$USER"
else
    echo -e "${YELLOW}[SKIP]${NC} zsh already default shell"
fi

echo "Shell tools installation complete!"
