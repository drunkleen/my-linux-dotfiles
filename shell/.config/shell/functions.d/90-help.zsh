shellhelp() {
  printf '%s%s shellhelp%s  %savailable shell shortcuts%s\n\n' "$_SHELL_UI_BOLD" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET" "$_SHELL_UI_DIM" "$_SHELL_UI_RESET"

  printf '%s%s Navigation%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'c, cls' 'Clear the terminal'
  printf '  %-14s %s\n' 'ls' 'List files with eza and icons'
  printf '  %-14s %s\n' 'l' 'Long file list'
  printf '  %-14s %s\n' 'll' 'Long all-files list'
  printf '  %-14s %s\n' 'ld' 'Long directory-only list'
  printf '  %-14s %s\n' 'lt' 'Tree view, depth 1'
  printf '  %-14s %s\n' 'lz' 'Fallback plain ls alias'
  printf '  %-14s %s\n' '.. / ... / .3' 'Go up directories quickly'
  printf '  %-14s %s\n' '.4 / .5' 'Go up 4 or 5 directories'
  printf '  %-14s %s\n\n' 'mkdir' 'Always create parent directories'

  printf '%s%s Editors and Files%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'vc' 'Open VS Code'
  printf '  %-14s %s\n' 'vim' 'Use Neovim'
  printf '  %-14s %s\n' 'cat' 'Use bat instead of cat'
  printf '  %-14s %s\n' 'open PATH' 'Open a file or URL with xdg-open'
  printf '  %-14s %s\n\n' 'opendir [PATH]' 'Open a directory in Nautilus'

  printf '%s%s Packages%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_PKG" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'update' 'Update system packages, prefers yay if present'
  printf '  %-14s %s\n' 'install PKG' 'Install package(s) with pacman'
  printf '  %-14s %s\n' 'remove PKG' 'Remove package(s) with pacman'
  printf '  %-14s %s\n' 'remove_deps' 'Remove package(s) and dependencies'
  printf '  %-14s %s\n' 'search QUERY' 'Search pacman repositories'
  printf '  %-14s %s\n' 'list' 'List installed packages'
  printf '  %-14s %s\n' 'info PKG' 'Show installed package info'
  printf '  %-14s %s\n' 'aur_install' 'Install AUR package(s) with yay'
  printf '  %-14s %s\n' 'aur_remove' 'Remove AUR package(s)'
  printf '  %-14s %s\n' 'aur_remove_deps' 'Remove AUR package(s) with deps'
  printf '  %-14s %s\n' 'aur_search' 'Search AUR packages'
  printf '  %-14s %s\n' 'aur_list' 'List installed AUR packages'
  printf '  %-14s %s\n\n' 'aur_info' 'Show AUR package info'

  printf '%s%s Containers%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_DOCKER" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'docker' 'Run docker through sudo'
  printf '  %-14s %s\n' 'dockerstart' 'Start Docker service'
  printf '  %-14s %s\n' 'dockerstop' 'Stop Docker service and socket'
  printf '  %-14s %s\n' 'dockerlist' 'List running containers'
  printf '  %-14s %s\n' 'pgstart' 'Start PostgreSQL and pgAdmin containers'
  printf '  %-14s %s\n' 'pgstop' 'Stop PostgreSQL and pgAdmin containers'
  printf '  %-14s %s\n' 'mongostart' 'Start MongoDB container'
  printf '  %-14s %s\n' 'mongostop' 'Stop MongoDB container'
  printf '  %-14s %s\n' 'redisstart' 'Start Redis container'
  printf '  %-14s %s\n' 'redisstop' 'Stop Redis container'
  printf '  %-14s %s\n' 'searxstart' 'Start SearX container'
  printf '  %-14s %s\n\n' 'searxstop' 'Stop SearX container'

  printf '%s%s Projects%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_BUILD" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'initmvn NAME' 'Create a Maven project skeleton'
  printf '  %-14s %s\n\n' 'initgo NAME' 'Create a Go project skeleton'

  printf '%s%s Network and Notify%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_NET" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'send-notif' 'Send a message to your ntfy topic'
  printf '  %-14s %s\n' 'iporigin ARG' 'Resolve and geo-look up IP/domain/URL'
  printf '  %-14s %s\n\n' 'ips' 'Show local and public IP addresses'

  printf '%s%s Help%s\n' "$_SHELL_UI_BLUE" "$_SHELL_ICON_INFO" "$_SHELL_UI_RESET"
  printf '  %-14s %s\n' 'shellhelp' 'Show this help page'
  printf '  %-14s %s\n' 'ntool help' 'Show ntool command help'
}
