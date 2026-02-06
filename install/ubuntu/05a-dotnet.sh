#!/bin/bash
# Install .NET tools: dotnet SDK, ef, csharpier
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

# Activate mise
if is_installed mise; then
    eval "$(mise activate bash)"
fi

echo "Installing .NET tools..."

# dotnet SDK
if is_installed dotnet; then
    echo -e "${YELLOW}[SKIP]${NC} dotnet already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} dotnet SDK"
    mise use -g dotnet
fi

# dotnet-ef
if dotnet tool list -g | grep -q "dotnet-ef"; then
    echo -e "${YELLOW}[SKIP]${NC} dotnet-ef already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} dotnet-ef"
    dotnet tool install -g dotnet-ef
fi

# csharpier
if dotnet tool list -g | grep -q "csharpier"; then
    echo -e "${YELLOW}[SKIP]${NC} csharpier already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} csharpier"
    dotnet tool install -g csharpier
fi

echo ".NET tools installation complete!"
