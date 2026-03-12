#!/usr/bin/env bash

ntool_icon() {
    case "$1" in
        title) printf '⚙' ;;
        overview) printf '◆' ;;
        service) printf '🛠' ;;
        network) printf '🌐' ;;
        example) printf '➜' ;;
        ok) printf '✔' ;;
        warn) printf '▲' ;;
        bad) printf '✖' ;;
        host) printf '🖥' ;;
        distro) printf '📦' ;;
        time) printf '🕒' ;;
        wifi) printf '📶' ;;
        route) printf '⇄' ;;
        dns) printf '🧭' ;;
        shield) printf '🔐' ;;
        ssh) printf '⌁' ;;
        ts) printf '◉' ;;
        iface) printf '◌' ;;
        *) printf '•' ;;
    esac
}

ntool_heading() {
    printf '%s%s %s%s\n' "$C_BOLD" "$1" "$2" "$C_RESET"
}

ntool_kv() {
    printf '  %s%-14s%s %s\n' "$C_DIM" "$1" "$C_RESET" "$2"
}

ntool_state_style() {
    case "$1" in
        active|enabled|ok|reachable|working) printf '%s' "$C_GREEN" ;;
        degraded|warn) printf '%s' "$C_YELLOW" ;;
        unavailable|inactive|disabled|failed) printf '%s' "$C_RED" ;;
        *) printf '%s' "$C_DIM" ;;
    esac
}

ntool_state_text() {
    local state="$1"
    local color
    color="$(ntool_state_style "$state")"
    printf '%s%s%s' "$color" "$state" "$C_RESET"
}

ntool_usage() {
    printf '%s%s ntool%s  %slocal network and service utility%s\n\n' "$C_BOLD" "$(ntool_icon title)" "$C_RESET" "$C_DIM" "$C_RESET"

    ntool_heading "$(ntool_icon overview)" "Usage"
    printf '  %sntool%s %sCOMMAND%s [ARG...]\n' "$C_CYAN" "$C_RESET" "$C_BOLD" "$C_RESET"
    printf '  %sntool%s help\n\n' "$C_CYAN" "$C_RESET"

    ntool_heading "$(ntool_icon overview)" "Overview"
    printf '  %-20s %s\n' 'status' 'Show a plain status report'
    printf '  %-20s %s\n' 'summary' 'Alias for status'
    printf '  %-20s %s\n' 'watch [SECONDS]' 'Refresh the status report every N seconds'
    printf '  %-20s %s\n\n' 'json' 'Print the full snapshot as JSON'

    ntool_heading "$(ntool_icon service)" "Services"
    printf '  %-28s %s\n' 'vpn on|off|status' "Manage WireGuard profile \"${NTOOL_VPN_PROFILE}\""
    printf '  %-28s %s\n' 'lan on|off|status' "Manage WireGuard profile \"${NTOOL_LAN_PROFILE}\""
    printf '  %-28s %s\n' 'ssh on|off|restart|status' 'Manage the sshd service'
    printf '  %-28s %s\n' 'ssh enable|disable|port' 'Manage sshd boot state and show port'
    printf '  %-28s %s\n' 'ts on|off|status|ip|peers' 'Manage the Tailscale client'
    printf '  %-28s %s\n\n' 'tsd on|off|enable|disable' 'Manage the tailscaled daemon'

    ntool_heading "$(ntool_icon network)" "Network"
    printf '  %-20s %s\n' 'ifaces' 'List interfaces'
    printf '  %-20s %s\n' 'ips' 'List interface addresses'
    printf '  %-20s %s\n' 'ip IFACE' 'Show one interface'
    printf '  %-20s %s\n' 'devices' 'Show interfaces in a compact table'
    printf '  %-20s %s\n' 'routes' 'Show routes'
    printf '  %-20s %s\n' 'gateway' 'Show the default gateway'
    printf '  %-20s %s\n' 'dns' 'Show DNS servers'
    printf '  %-20s %s\n' 'public-ip' 'Show public IPv4'
    printf '  %-20s %s\n' 'public-ip6' 'Show public IPv6'
    printf '  %-20s %s\n' 'ports' 'Show listening ports'
    printf '  %-20s %s\n' 'ping HOST' 'Ping a host'
    printf '  %-20s %s\n' 'resolve HOST' 'Resolve a host'
    printf '  %-20s %s\n\n' 'checks' 'Run connectivity checks'

    ntool_heading "$(ntool_icon example)" "Examples"
    printf '  %sntool status%s\n' "$C_CYAN" "$C_RESET"
    printf '  %sntool watch 2%s\n' "$C_CYAN" "$C_RESET"
    printf '  %sntool ssh status%s\n' "$C_CYAN" "$C_RESET"
    printf '  %sntool ts ip%s\n' "$C_CYAN" "$C_RESET"
    printf '  %sntool resolve example.com%s\n' "$C_CYAN" "$C_RESET"
}

ntool_status() {
    local def_iface gateway ip4 ip6 public4 public6 wifi_ssid wifi_signal
    def_iface="$(ntool_default_iface || true)"
    gateway="$(ntool_gateway || true)"
    ip4="$(ntool_primary_ip4 "$def_iface" || true)"
    ip6="$(ntool_primary_ip6 "$def_iface" || true)"
    public4="$(ntool_public_ip4 || true)"
    public6="$(ntool_public_ip6 || true)"
    wifi_ssid="$(ntool_wifi_ssid || true)"
    wifi_signal="$(ntool_wifi_signal || true)"

    printf '%s%s ntool status%s\n' "$C_BOLD" "$(ntool_icon title)" "$C_RESET"
    ntool_kv "$(ntool_icon host) host" "${HOSTNAME:-$(hostname 2>/dev/null || printf 'unknown-host')}"
    if [[ -f /etc/os-release ]]; then
        ntool_kv "$(ntool_icon distro) distro" "$(awk -F= '/^PRETTY_NAME=/{gsub(/"/,"",$2); print $2; exit}' /etc/os-release)"
    else
        ntool_kv "$(ntool_icon distro) distro" "Linux"
    fi
    ntool_kv "$(ntool_icon time) updated" "$(date --iso-8601=seconds 2>/dev/null || date)"

    printf '\n'
    ntool_heading "$(ntool_icon network)" "Network"
    ntool_kv "default iface" "${def_iface:-n/a}"
    ntool_kv "$(ntool_icon route) gateway" "${gateway:-n/a}"
    ntool_kv "ipv4" "${ip4:-n/a}"
    ntool_kv "ipv6" "${ip6:-n/a}"
    ntool_kv "public ipv4" "${public4:-n/a}"
    ntool_kv "public ipv6" "${public6:-n/a}"
    ntool_kv "$(ntool_icon wifi) wifi ssid" "${wifi_ssid:-n/a}"
    ntool_kv "wifi signal" "${wifi_signal:-n/a}"
    ntool_kv "$(ntool_icon dns) dns" "$(grep -E '^\s*nameserver\s+' /etc/resolv.conf 2>/dev/null | awk '{print $2}' | paste -sd ', ' - || true)"

    printf '\n'
    ntool_heading "$(ntool_icon service)" "Services"
    printf '  %-16s %-18s %s\n' "$(ntool_icon shield) WireGuard VPN" "$(ntool_state_text "$(ntool_wireguard_state "$NTOOL_VPN_PROFILE")")" "profile ${NTOOL_VPN_PROFILE}"
    printf '  %-16s %-18s %s\n' "$(ntool_icon shield) WireGuard LAN" "$(ntool_state_text "$(ntool_wireguard_state "$NTOOL_LAN_PROFILE")")" "profile ${NTOOL_LAN_PROFILE}"
    printf '  %-16s %-18s %s\n' "$(ntool_icon ssh) SSH" "$(ntool_state_text "$(ntool_ssh_state)")" "OpenSSH service"
    printf '  %-16s %-18s %s\n' "$(ntool_icon ts) Tailscale" "$(ntool_state_text "$(ntool_tailscale_state)")" "tailscale client session"
    printf '  %-16s %-18s %s\n' "$(ntool_icon ts) Tailscaled" "$(ntool_state_text "$(ntool_tailscaled_state)")" "tailscale daemon"

    printf '\n'
    ntool_heading "$(ntool_icon iface)" "Interfaces"
    while read -r iface state rest; do
        [[ -n "$iface" ]] || continue
        printf '  %-12s %-10s %-18s %s\n' "$iface" "$(ntool_iface_kind "$iface")" "$(ntool_state_text "$state")" "${rest:-n/a}"
    done < <(ntool_iface_lines || true)

    printf '\n'
    ntool_heading "$(ntool_icon route)" "Routes"
    ntool_routes 2>/dev/null | sed 's/^/  /' || true

    printf '\n'
    ntool_heading "$(ntool_icon ok)" "Checks"
    ntool_checks | sed 's/^/  /' || true
}
