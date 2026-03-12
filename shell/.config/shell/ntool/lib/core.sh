#!/usr/bin/env bash

NTOOL_VPN_PROFILE="${NTOOL_VPN_PROFILE:-myvpn}"
NTOOL_LAN_PROFILE="${NTOOL_LAN_PROFILE:-mylan}"

if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
    C_RESET=$'\033[0m'
    C_BOLD=$'\033[1m'
    C_DIM=$'\033[2m'
    C_BLUE=$'\033[38;5;111m'
    C_GREEN=$'\033[38;5;114m'
    C_YELLOW=$'\033[38;5;221m'
    C_RED=$'\033[38;5;203m'
    C_CYAN=$'\033[38;5;117m'
else
    C_RESET=''
    C_BOLD=''
    C_DIM=''
    C_BLUE=''
    C_GREEN=''
    C_YELLOW=''
    C_RED=''
    C_CYAN=''
fi

ntool_has() {
    command -v "$1" >/dev/null 2>&1
}

ntool_err() {
    printf 'ntool: %s\n' "$*" >&2
}

ntool_info() {
    printf '%s\n' "$*"
}

ntool_json_escape() {
    local value="${1-}"
    value=${value//\\/\\\\}
    value=${value//\"/\\\"}
    value=${value//$'\n'/\\n}
    value=${value//$'\r'/}
    value=${value//$'\t'/\\t}
    printf '%s' "$value"
}

ntool_json_array_from_lines() {
    local first=1 line
    printf '['
    while IFS= read -r line; do
        [[ -n "$line" ]] || continue
        if [[ $first -eq 0 ]]; then
            printf ', '
        fi
        first=0
        printf '"%s"' "$(ntool_json_escape "$line")"
    done
    printf ']'
}
