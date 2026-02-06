# Fuzzy directory finder - cd into selected directory (top-level ~/dev folders only)
f() {
    local dir
    dir=$(fd --type d --max-depth 1 --base-directory /home/$USER/dev | \
    fzf --preview "eza --tree --level=1 --color=always /home/$USER/dev/{}" \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')
    if [ -n "$dir" ]; then
        cd "/home/$USER/dev/$dir"
    fi
}

# Fuzzy directory finder - cd into selected directory (top-level Windows home folders only)
# WSL only: navigates /mnt/c/Users/<username>
fw() {
    local win_user=$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r')
    local win_home="/mnt/c/Users/$win_user"
    local dir
    dir=$(fd --type d --max-depth 1 --base-directory "$win_home" | \
    fzf --preview "eza --tree --level=1 --color=always $win_home/{}" \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')
    if [ -n "$dir" ]; then
        cd "$win_home/$dir"
    fi
}

# Fuzzy directory finder (deep) - cd into selected directory (including subfolders)
fdd() {
    local dir
    dir=$(fd --type d \
        --exclude node_modules \
        --exclude .git \
        --exclude .cache \
        --exclude .vscode \
        --exclude .npm \
        --exclude dist \
        --exclude .bun \
        --exclude .local \
        --exclude .next \
        --exclude .expo \
        --exclude .asdf \
        --exclude .docker \
        --exclude build \
        . /home/$USER/dev | \
    awk -F'/' '{if(NF>=2) print "../"$(NF-1)"/"$NF"\t"$0; else print $0"\t"$0}' | \
    fzf --delimiter='\t' --with-nth=1 \
        --preview 'eza --tree --level=1 --color=always {2}' \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' | \
    cut -f2)
    if [ -n "$dir" ]; then
        cd "$dir"
    fi
}

# Fuzzy file finder - open selected file in nvim
ff() {
    local file
    file=$(fd --type f \
        --exclude node_modules \
        --exclude .git \
        --exclude .cache \
        --exclude .vscode \
        --exclude .npm \
        --exclude dist \
        --exclude .bun \
        --exclude .local \
        --exclude .next \
        --exclude .expo \
        --exclude db \
        --exclude .asdf \
        --exclude build \
        --exclude __pycache__ \
        --exclude .idea \
        --exclude .env \
        --exclude .vs \
        --exclude vendor \
        --exclude coverage \
        --exclude .terraform \
        --exclude .bundle \
        --exclude tmp \
        --exclude logs \
        --exclude .sass-cache \
        --exclude .docker \
        . /home/$USER/dev /home/$USER/.config | \
    fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')
    if [ -n "$file" ]; then
        nvim "$file"
    fi
}
