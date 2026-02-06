# Mise - tool manager 
eval "$(mise activate zsh)"

# Starship prompt
eval "$(starship init zsh)"

# Zoxide - smarter cd
eval "$(zoxide init --cmd z zsh)"

# Fzf - key bindings (Ctrl-R, Ctrl-T, Alt-C) and completion
eval "$(fzf --zsh)"
