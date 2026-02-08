#!/bin/bash
# Install JavaScript tools: node, pnpm, bun (via mise)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

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

echo "JavaScript tools installation complete!"
