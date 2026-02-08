#!/bin/bash
# Root sync script - select and run sync scripts via fzf

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Activate mise to get tools like fzf in PATH
export PATH="$HOME/.local/bin:$PATH"
if command -v mise &> /dev/null; then
    eval "$(mise activate bash)"
fi

# Find all sync.sh scripts in subdirectories (excluding this root script)
mapfile -t SYNC_SCRIPTS < <(find "$SCRIPT_DIR" -mindepth 2 -name "sync.sh" -type f | sort)

if [ ${#SYNC_SCRIPTS[@]} -eq 0 ]; then
    echo "No sync scripts found."
    exit 1
fi

# Build list with relative paths for display
OPTIONS=("all")
for script in "${SYNC_SCRIPTS[@]}"; do
    OPTIONS+=("${script#$SCRIPT_DIR/}")
done

# Show menu (fzf if available, otherwise fallback to numbered list)
if command -v fzf &> /dev/null; then
    SELECTION=$(printf '%s\n' "${OPTIONS[@]}" | fzf --prompt="Select sync script: " --height=40% --reverse)
else
    echo "Select sync script:"
    echo ""
    for i in "${!OPTIONS[@]}"; do
        echo "  $i) ${OPTIONS[$i]}"
    done
    echo ""
    read -p "Enter number: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -lt ${#OPTIONS[@]} ]; then
        SELECTION="${OPTIONS[$choice]}"
    else
        SELECTION=""
    fi
fi

if [ -z "$SELECTION" ]; then
    echo "No selection made."
    exit 0
fi

# Execute based on selection
if [ "$SELECTION" = "all" ]; then
    echo "Running all sync scripts..."
    echo ""
    for script in "${SYNC_SCRIPTS[@]}"; do
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "Running: ${script#$SCRIPT_DIR/}"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        bash "$script"
        echo ""
    done
    echo "All sync scripts completed!"
else
    bash "$SCRIPT_DIR/$SELECTION"
fi
