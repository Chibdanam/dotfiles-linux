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
