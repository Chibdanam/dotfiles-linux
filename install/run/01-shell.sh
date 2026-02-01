#!/bin/bash
# Install shell tools: zsh, git-delta, starship

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing shell tools..."

# zsh
if is_installed zsh; then
    echo -e "${YELLOW}[SKIP]${NC} zsh already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} zsh"
    yay -Syu --noconfirm zsh
fi

# Set zsh as default shell
if [ "$SHELL" = "/usr/bin/zsh" ]; then
    echo -e "${YELLOW}[SKIP]${NC} zsh already default shell"
else
    echo -e "${GREEN}[CONFIG]${NC} Setting zsh as default shell"
    chsh -s /usr/bin/zsh
fi

# git-delta
if is_installed delta; then
    echo -e "${YELLOW}[SKIP]${NC} git-delta already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} git-delta"
    yay -Syu --noconfirm git-delta
fi

# starship
if is_installed starship; then
    echo -e "${YELLOW}[SKIP]${NC} starship already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} starship"
    yay -Syu --noconfirm starship
fi

echo "Shell tools installation complete!"
