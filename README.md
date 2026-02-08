# dotfiles

Distro-agnostic dotfiles for Linux (Arch, Ubuntu/Debian). Works on WSL, bare metal, and servers.

## What's Included

| Component | Tool | Config |
|-----------|------|--------|
| Shell | Zsh + [Zinit](https://github.com/zdharma-continuum/zinit) | `zsh/` |
| Prompt | [Starship](https://starship.rs/) | `starship/` |
| Editor | [Neovim](https://neovim.io/) | `neovim/` |
| Multiplexer | [tmux](https://github.com/tmux/tmux) | `tmux/` |
| Tool Manager | [mise](https://mise.jdx.dev/) | `mise/` |
| Git | delta, lazygit | `git/` |

**CLI utilities** (via mise): ripgrep, bat, eza, fd, sd, fzf, zoxide, bottom, fastfetch, delta

## Repository Structure

```
dotfiles/
├── install/
│   ├── install.sh          # Interactive installer (fzf menu)
│   ├── lib.sh              # Shared helpers (pkg_install, detect_distro)
│   └── scripts/            # Install scripts (distro-agnostic)
│       ├── 00-wsl-init.sh  # WSL bootstrap (run as root, one-time)
│       ├── 01-prerequisites.sh
│       ├── 02-shell.sh
│       ├── 03-utilities.sh
│       ├── 04-dev-core.sh
│       ├── 05-javascript.sh
│       ├── 05a-dotnet.sh
│       ├── 06-databases.sh
│       └── 07-ai.sh
├── git/                    # .gitconfig
├── mise/                   # Unified tool manager config
├── neovim/                 # Neovim config (lazy.nvim)
├── starship/               # Starship prompt config
├── tmux/                   # tmux config (catppuccin, resurrect)
├── zsh/                    # Zsh modules (.zshrc, aliases, functions, etc.)
└── sync.sh                 # Sync configs to home directory
```

## Installation

### Fresh WSL Instance

```bash
# Run as root inside a fresh WSL instance (Arch or Ubuntu)
wsl -d <distro> -u root -- bash install/scripts/00-wsl-init.sh
# Restart WSL, then continue below
```

### Install Tools

```bash
./install/install.sh
```

Interactive menu to install individually or all at once:
- **prerequisites** — build tools, git, mise, rustup
- **shell** — zsh
- **utilities** — tmux, unzip (CLI tools via mise)
- **dev-core** — cmake, python, docker
- **javascript** — node, pnpm, bun
- **dotnet** — .NET SDK, dotnet-ef, csharpier
- **databases** — lazysql
- **ai** — claude-code, opencode

### Sync Configs

```bash
./sync.sh
```

Copies/symlinks config files to their expected locations (`~/.config/nvim/`, `~/.zshrc`, etc.).

## How It Works

**Distro detection** happens at runtime — `lib.sh` reads `/etc/os-release` and routes to `pacman` or `apt` as needed via `pkg_install()`. Most tools are installed through **mise**, making them identical across distros. Only true system packages (zsh, tmux, unzip, cmake, python, build tools) go through the package manager.

**Supported distros:** Arch, Manjaro, EndeavourOS, Ubuntu, Debian, Linux Mint, Pop!_OS
