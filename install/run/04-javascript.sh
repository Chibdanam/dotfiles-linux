#!/bin/bash
# Install JavaScript tools: node, pnpm, bun, eas-cli

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

# Activate mise
if is_installed mise; then
    eval "$(mise activate bash)"
fi

echo "Installing JavaScript tools..."

# node (LTS)
if is_installed node; then
    echo -e "${YELLOW}[SKIP]${NC} node already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} node (LTS)"
    mise use -g node@lts
fi

# pnpm
if is_installed pnpm; then
    echo -e "${YELLOW}[SKIP]${NC} pnpm already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} pnpm"
    mise use -g pnpm
fi

# bun
if is_installed bun; then
    echo -e "${YELLOW}[SKIP]${NC} bun already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} bun"
    mise use -g bun
fi

# eas-cli
if is_installed eas; then
    echo -e "${YELLOW}[SKIP]${NC} eas-cli already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} eas-cli"
    npm install -g eas-cli
fi

echo "JavaScript tools installation complete!"
