#!/usr/bin/env bash

ntool_iface_kind() {
    case "$1" in
        lo) printf 'loopback' ;;
        wl*|wlan*) printf 'wifi' ;;
        en*|eth*) printf 'ethernet' ;;
        wg*) printf 'wireguard' ;;
        tun*) printf 'tunnel' ;;
        tailscale*) printf 'tailscale' ;;
        docker*|br-*) printf 'bridge' ;;
        *) printf 'other' ;;
    esac
}

ntool_iface_lines() {
    ip -brief addr 2>/dev/null || return 1
}

ntool_ifaces() {
    ip -brief link
}

ntool_ips() {
    ntool_iface_lines
}

ntool_ip() {
    local iface="${1:-}"
    if [[ -z "$iface" ]]; then
        ntool_err 'usage: ntool ip <interface>'
        return 1
    fi
    ip -brief addr show dev "$iface"
}

ntool_devices() {
    local iface state rest
    printf '%-14s %-12s %-10s %s\n' "INTERFACE" "TYPE" "STATE" "ADDR"
    while read -r iface state rest; do
        [[ -n "$iface" ]] || continue
        printf '%-14s %-12s %-10s %s\n' \
            "$iface" \
            "$(ntool_iface_kind "$iface")" \
            "$state" \
            "${rest:-n/a}"
    done < <(ntool_iface_lines)
}

ntool_default_iface() {
    ip route show default 2>/dev/null | awk 'NR==1 {for (i=1;i<=NF;i++) if ($i=="dev") {print $(i+1); exit}}'
}

ntool_gateway() {
    ip route show default 2>/dev/null | awk 'NR==1 {print $3}'
}

ntool_primary_ip4() {
    local iface="${1:-}"
    [[ -n "$iface" ]] || return 0
    ip -brief addr show dev "$iface" 2>/dev/null | awk '{for (i=3;i<=NF;i++) if ($i ~ /\./) {print $i; exit}}'
}

ntool_primary_ip6() {
    local iface="${1:-}"
    [[ -n "$iface" ]] || return 0
    ip -brief addr show dev "$iface" 2>/dev/null | awk '{for (i=3;i<=NF;i++) if ($i ~ /:/) {print $i; exit}}'
}

ntool_routes() {
    ip route
}

ntool_dns() {
    if ntool_has resolvectl; then
        resolvectl dns 2>/dev/null || resolvectl status
    elif [[ -f /etc/resolv.conf ]]; then
        grep -E '^\s*nameserver\s+' /etc/resolv.conf || cat /etc/resolv.conf
    else
        ntool_err 'no DNS info source found'
        return 1
    fi
}

ntool_public_ip4() {
    if ntool_has curl; then
        curl -4fsS --max-time 2 https://api.ipify.org 2>/dev/null || true
    elif ntool_has wget; then
        wget -4qO- --timeout=2 https://api.ipify.org 2>/dev/null || true
    fi
}

ntool_public_ip6() {
    if ntool_has curl; then
        curl -6fsS --max-time 2 https://api64.ipify.org 2>/dev/null || true
    elif ntool_has wget; then
        wget -6qO- --timeout=2 https://api64.ipify.org 2>/dev/null || true
    fi
}

ntool_wifi_ssid() {
    if ntool_has nmcli; then
        nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | awk -F: '$1=="yes" {print $2; exit}'
    elif ntool_has iwgetid; then
        iwgetid -r 2>/dev/null || true
    fi
}

ntool_wifi_signal() {
    if ntool_has nmcli; then
        nmcli -t -f ACTIVE,SIGNAL dev wifi 2>/dev/null | awk -F: '$1=="yes" {print $2 "%"; exit}'
    fi
}

ntool_ports() {
    if ntool_has ss; then
        ss -tulpn
    else
        ntool_err 'ss is not installed'
        return 1
    fi
}

ntool_ping() {
    local host="${1:-1.1.1.1}"
    ping -c 4 "$host"
}

ntool_resolve() {
    local host="${1:-}"
    if [[ -z "$host" ]]; then
        ntool_err 'usage: ntool resolve <host>'
        return 1
    fi

    if ntool_has resolvectl; then
        resolvectl query "$host"
    elif ntool_has getent; then
        getent ahosts "$host"
    else
        ntool_err 'no resolver tool found'
        return 1
    fi
}

ntool_check_ipv4() {
    if ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1; then
        printf 'ok reachable\n'
    else
        printf 'degraded failed\n'
    fi
}

ntool_check_ipv6() {
    if ping -6 -c 1 -W 2 2606:4700:4700::1111 >/dev/null 2>&1; then
        printf 'ok reachable\n'
    else
        printf 'degraded failed\n'
    fi
}

ntool_check_dns() {
    if ntool_has getent && getent hosts example.com >/dev/null 2>&1; then
        printf 'ok working\n'
    else
        printf 'degraded failed\n'
    fi
}

ntool_checks() {
    local state detail

    read -r state detail < <(ntool_check_ipv4)
    printf '%-8s %-10s %s\n' "IPv4" "$(ntool_state_text "$state")" "$detail"

    read -r state detail < <(ntool_check_ipv6)
    printf '%-8s %-10s %s\n' "IPv6" "$(ntool_state_text "$state")" "$detail"

    read -r state detail < <(ntool_check_dns)
    printf '%-8s %-10s %s\n' "DNS" "$(ntool_state_text "$state")" "$detail"
}

ntool_internet() {
    ntool_checks
}
