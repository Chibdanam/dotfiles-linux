alias v="nvim"
alias oc="opencode"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cd='z'

alias ls='eza'
alias lsa='eza -la'
alias ll='eza -la'
alias lt='eza --tree --level=2'

alias top='btm'
alias cat='bat --paging=never'
alias lg='lazygit'

alias mkcd='function _mkcd() { mkdir -p "$1" && cd "$1" }; _mkcd'
alias vswap="rm -rf ~/.local/state/nvim/swap/"
