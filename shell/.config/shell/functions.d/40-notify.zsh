send-notif() {
  local ntfy_topic="u6Wn2kcJvg0Wvm58i9ct3JuzFdETESwFh6mtFswx7JWLGuyFVf1gbNaYsUjKXunA"
  local ntfy_url="https://ntfy.sh/${ntfy_topic}"
  local ntfy_title="pi5 - Galaxy"
  local raw message

  command -v curl >/dev/null 2>&1 || {
    printf '%s%s Missing command:%s curl\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  }

  if (( $# == 0 )); then
    if [[ ! -t 0 ]]; then
      raw="$(cat)"
    else
      printf '%s%s Usage:%s send-notif <message>\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
      return 1
    fi
  else
    raw="$*"
  fi

  raw=${raw//'%'/'%%'}
  printf -v message "%b" "$raw"

  if curl -fsS -o /dev/null \
    -H "Title: ${ntfy_title}" \
    --data-binary "$message" \
    "$ntfy_url"; then
    printf '%s%s Notification sent%s\n' "$_SHELL_UI_GREEN" "$_SHELL_ICON_NOTE" "$_SHELL_UI_RESET"
  else
    printf '%s%s Failed to send notification%s\n' "$_SHELL_UI_RED" "$_SHELL_ICON_ERR" "$_SHELL_UI_RESET" >&2
    return 1
  fi
}
