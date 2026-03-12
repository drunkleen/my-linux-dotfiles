update() {
  if shell_has yay; then
    yay -Syu "$@"
  else
    sudo pacman -Syu "$@"
  fi
}

install() {
  (( $# )) || shell_fail "Usage: install <package...>" || return 1
  sudo pacman -S "$@"
}

remove() {
  (( $# )) || shell_fail "Usage: remove <package...>" || return 1
  sudo pacman -R "$@"
}

remove_deps() {
  (( $# )) || shell_fail "Usage: remove_deps <package...>" || return 1
  sudo pacman -Rns "$@"
}

search() {
  (( $# )) || shell_fail "Usage: search <query>" || return 1
  pacman -Ss "$@"
}

list() {
  pacman -Q
}

info() {
  (( $# )) || shell_fail "Usage: info <package...>" || return 1
  pacman -Qi "$@"
}

aur_install() {
  shell_need yay || return 1
  (( $# )) || shell_fail "Usage: aur_install <package...>" || return 1
  yay -S "$@"
}

aur_remove() {
  shell_need yay || return 1
  (( $# )) || shell_fail "Usage: aur_remove <package...>" || return 1
  yay -R "$@"
}

aur_remove_deps() {
  shell_need yay || return 1
  (( $# )) || shell_fail "Usage: aur_remove_deps <package...>" || return 1
  yay -Rns "$@"
}

aur_search() {
  shell_need yay || return 1
  (( $# )) || shell_fail "Usage: aur_search <query>" || return 1
  yay -Ss "$@"
}

aur_list() {
  shell_need yay || return 1
  yay -Qm
}

aur_info() {
  shell_need yay || return 1
  (( $# )) || shell_fail "Usage: aur_info <package...>" || return 1
  yay -Qi "$@"
}
