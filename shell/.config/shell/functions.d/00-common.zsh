shell_has() {
  command -v "$1" >/dev/null 2>&1
}

shell_need() {
  if ! shell_has "$1"; then
    echo "Missing command: $1" >&2
    return 1
  fi
}

shell_info() {
  echo "$@"
}

shell_warn() {
  echo "$@" >&2
}

shell_ok() {
  echo "$@"
}

shell_fail() {
  echo "$@" >&2
  return 1
}

open() {
  shell_need xdg-open || return 1
  xdg-open "$@" >/dev/null 2>&1 &
}

opendir() {
  if shell_has nautilus; then
    nautilus "${1:-.}" >/dev/null 2>&1 &
  else
    open "${1:-.}"
  fi
}
