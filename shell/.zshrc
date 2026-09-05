# Add your own exports, aliases, and functions here.
#
# Shared, shell-agnostic config (theme + aliases + functions)
export SHELL_SHARED_DIR="$HOME/.config/shell/shared"
source "$SHELL_SHARED_DIR/theme.sh"
source "$SHELL_SHARED_DIR/aliases.sh"
source "$SHELL_SHARED_DIR/functions.sh"

# Zsh entry point. All real config lives in ~/.config/shell/zsh/.
[[ -f "$HOME/.config/shell/zsh/init.zsh" ]] && source "$HOME/.config/shell/zsh/init.zsh"

eval $(thefuck --alias)
