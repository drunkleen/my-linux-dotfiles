send-notif() {
  local ntfy_topic="u6Wn2kcJvg0Wvm58i9ct3JuzFdETESwFh6mtFswx7JWLGuyFVf1gbNaYsUjKXunA"
  local ntfy_url="https://ntfy.sh/${ntfy_topic}"
  local raw message

  shell_need curl || return 1

  if (( $# == 0 )); then
    if [[ ! -t 0 ]]; then
      raw="$(cat)"
    else
      shell_fail "Usage: send-notif <message>" || return 1
    fi
  else
    raw="$*"
  fi

  raw=${raw//'%'/'%%'}
  printf -v message "%b" "$raw"

  if curl -fsS -o /dev/null --data-binary "$message" "$ntfy_url"; then
    echo "Notification sent."
  else
    shell_fail "Failed to send notification." || return 1
  fi
}
