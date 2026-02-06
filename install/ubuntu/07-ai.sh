#!/bin/bash
# Install AI tools: claude-code, opencode

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

# Ensure mise is activated for this session (node is needed for claude-code)
eval "$(mise activate bash)" 2>/dev/null || {
    echo -e "${RED}[ERROR]${NC} mise not found. Run 01-prerequisites.sh first."
    exit 1
}

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
