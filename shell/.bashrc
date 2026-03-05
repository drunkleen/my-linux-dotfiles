# zsh

# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Leenium aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/leenium/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
. "$HOME/.cargo/env"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

. "$HOME/.local/share/../bin/env"

# alias powerprofilesctl="/usr/bin/python /usr/bin/powerprofilesctl"
