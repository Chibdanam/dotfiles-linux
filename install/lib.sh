#!/bin/bash
# Shared functions for install and sync scripts

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

is_installed() {
    command -v "$1" &> /dev/null
}

detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            arch|archarm|endeavouros|manjaro)
                echo "arch"
                ;;
            ubuntu|debian|linuxmint|pop)
                echo "ubuntu"
                ;;
            *)
                echo "unknown"
                ;;
        esac
    else
        echo "unknown"
    fi
}

pkg_update() {
    local distro
    distro=$(detect_distro)
    echo -e "${GREEN}[UPDATE]${NC} Updating package index"
    case "$distro" in
        arch)   sudo pacman -Syu --noconfirm ;;
        ubuntu) sudo apt update && sudo apt upgrade -y ;;
    esac
}

pkg_install() {
    local pkg="$1"
    local distro
    distro=$(detect_distro)
    case "$distro" in
        arch)
            if pacman -Qi "$pkg" &> /dev/null; then
                echo -e "${YELLOW}[SKIP]${NC} $pkg already installed"
            else
                echo -e "${GREEN}[INSTALL]${NC} $pkg (pacman)"
                sudo pacman -S --noconfirm --needed "$pkg"
            fi
            ;;
        ubuntu)
            if dpkg -l "$pkg" 2>/dev/null | grep -q "^ii"; then
                echo -e "${YELLOW}[SKIP]${NC} $pkg already installed"
            else
                echo -e "${GREEN}[INSTALL]${NC} $pkg (apt)"
                sudo apt install -y "$pkg"
            fi
            ;;
        *)
            echo -e "${RED}[ERROR]${NC} Unsupported distro for pkg_install: $distro"
            return 1
            ;;
    esac
}

is_wsl() {
    [[ -f /proc/version ]] && grep -qi microsoft /proc/version
}

ensure_mise_activated() {
    if is_installed mise; then
        eval "$(mise activate bash)"
    else
        echo -e "${RED}[ERROR]${NC} mise not found. Run 01-prerequisites.sh first."
        exit 1
    fi
}
