# Oh My Posh - enable hot reload for theme switching
oh-my-posh enable reload 2>/dev/null || true
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"

# Zoxide - smarter cd
eval "$(zoxide init --cmd z zsh)"
