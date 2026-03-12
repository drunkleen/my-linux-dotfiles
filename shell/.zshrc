# if [ -z "$TMUX" ]; then
#     tmux
# fi

if command -v leenfetch >/dev/null 2>&1; then
  leenfetch
fi

export PATH="$HOME/.local/bin:$PATH:$HOME/go/bin"

eval "$(mise activate zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh-my-zsh installation path
ZSH=$HOME/.oh-my-zsh

# Powerlevel10k theme path
source $ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=(
  git
  sudo
  zsh-256color
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf-tab
  zsh-bat
)

source $ZSH/oh-my-zsh.sh

[[ -f "$HOME/.config/shell/.alias" ]] && source "$HOME/.config/shell/.alias"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ctrl + R
# source <(fzf --zsh)

export SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent.sock"

# export MOZ_ENABLE_WAYLAND=1


# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
