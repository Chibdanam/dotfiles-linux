#!/bin/bash
# Install AI tools: claude-code, opencode

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

ensure_mise_activated

echo "Installing AI tools..."

# claude-code
if is_installed claude; then
    echo -e "${YELLOW}[SKIP]${NC} claude-code already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} claude-code"
    curl -fsSL https://claude.ai/install.sh | bash
fi

# opencode
if is_installed opencode; then
    echo -e "${YELLOW}[SKIP]${NC} opencode already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} opencode"
    curl -fsSL https://opencode.ai/install | bash
fi

echo "AI tools installation complete!"
