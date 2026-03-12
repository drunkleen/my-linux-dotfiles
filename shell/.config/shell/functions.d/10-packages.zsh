update() {
  printf '%s%s %sUpdating packages%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_PKG" "$_SHELL_UI_BOLD" "$_SHELL_UI_RESET"
  if command -v yay >/dev/null 2>&1; then
    yay -Syu "$@"
  else
    sudo pacman -Syu "$@"
  fi
}

install() {
  (( $# )) || {
    printf '%s%s Usage:%s install <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Installing:%s %s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET" "$*"
  sudo pacman -S "$@"
}

remove() {
  (( $# )) || {
    printf '%s%s Usage:%s remove <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Removing:%s %s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET" "$*"
  sudo pacman -R "$@"
}

remove_deps() {
  (( $# )) || {
    printf '%s%s Usage:%s remove_deps <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Removing with deps:%s %s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET" "$*"
  sudo pacman -Rns "$@"
}

search() {
  (( $# )) || {
    printf '%s%s Usage:%s search <query>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Searching repos:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET" "$*"
  pacman -Ss "$@"
}

list() {
  printf '%s%s Installed packages%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET"
  pacman -Q
}

info() {
  (( $# )) || {
    printf '%s%s Usage:%s info <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Package info:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET" "$*"
  pacman -Qi "$@"
}

aur_install() {
  command -v yay >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s yay\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  (( $# )) || {
    printf '%s%s Usage:%s aur_install <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Installing AUR:%s %s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_AUR" "$_SHELL_UI_RESET" "$*"
  yay -S "$@"
}

aur_remove() {
  command -v yay >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s yay\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  (( $# )) || {
    printf '%s%s Usage:%s aur_remove <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Removing AUR:%s %s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_AUR" "$_SHELL_UI_RESET" "$*"
  yay -R "$@"
}

aur_remove_deps() {
  command -v yay >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s yay\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  (( $# )) || {
    printf '%s%s Usage:%s aur_remove_deps <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Removing AUR with deps:%s %s\n' "$_SHELL_UI_YELLOW" "$_SHELL_ICON_AUR" "$_SHELL_UI_RESET" "$*"
  yay -Rns "$@"
}

aur_search() {
  command -v yay >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s yay\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  (( $# )) || {
    printf '%s%s Usage:%s aur_search <query>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Searching AUR:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_AUR" "$_SHELL_UI_RESET" "$*"
  yay -Ss "$@"
}

aur_list() {
  command -v yay >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s yay\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s Installed AUR packages%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_AUR" "$_SHELL_UI_RESET"
  yay -Qm
}

aur_info() {
  command -v yay >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s yay\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  (( $# )) || {
    printf '%s%s Usage:%s aur_info <package...>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }
  printf '%s%s AUR package info:%s %s\n' "$_SHELL_UI_CYAN" "$_SHELL_ICON_AUR" "$_SHELL_UI_RESET" "$*"
  yay -Qi "$@"
}
