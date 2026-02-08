#!/bin/bash
# Install database tools: lazysql

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

ensure_mise_activated

echo "Installing database tools..."

# lazysql (via go install - works on all distros)
if is_installed lazysql; then
    echo -e "${YELLOW}[SKIP]${NC} lazysql already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} lazysql"
    go install github.com/jorgerojas26/lazysql@latest
fi

echo "Database tools installation complete!"
