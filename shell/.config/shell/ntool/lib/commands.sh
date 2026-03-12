#!/usr/bin/env bash

ntool_json() {
    local def_iface gateway ip4 ip6 public4 public6 wifi_ssid wifi_signal distro host dns_lines iface_lines route_lines check_lines
    def_iface="$(ntool_default_iface || true)"
    gateway="$(ntool_gateway || true)"
    ip4="$(ntool_primary_ip4 "$def_iface" || true)"
    ip6="$(ntool_primary_ip6 "$def_iface" || true)"
    public4="$(ntool_public_ip4 || true)"
    public6="$(ntool_public_ip6 || true)"
    wifi_ssid="$(ntool_wifi_ssid || true)"
    wifi_signal="$(ntool_wifi_signal || true)"
    host="${HOSTNAME:-$(hostname 2>/dev/null || printf 'unknown-host')}"
    distro="$(awk -F= '/^PRETTY_NAME=/{gsub(/"/,"",$2); print $2; exit}' /etc/os-release 2>/dev/null || printf 'Linux')"
    dns_lines="$(grep -E '^\s*nameserver\s+' /etc/resolv.conf 2>/dev/null | awk '{print $2}')"
    iface_lines="$(ntool_iface_lines 2>/dev/null || true)"
    route_lines="$(ntool_routes 2>/dev/null || true)"
    check_lines="$(ntool_checks 2>/dev/null || true)"

    printf '{\n'
    printf '  "hostname": "%s",\n' "$(ntool_json_escape "$host")"
    printf '  "distro": "%s",\n' "$(ntool_json_escape "$distro")"
    printf '  "default_interface": "%s",\n' "$(ntool_json_escape "${def_iface:-}")"
    printf '  "gateway": "%s",\n' "$(ntool_json_escape "${gateway:-}")"
    printf '  "ipv4": "%s",\n' "$(ntool_json_escape "${ip4:-}")"
    printf '  "ipv6": "%s",\n' "$(ntool_json_escape "${ip6:-}")"
    printf '  "public_ipv4": "%s",\n' "$(ntool_json_escape "${public4:-}")"
    printf '  "public_ipv6": "%s",\n' "$(ntool_json_escape "${public6:-}")"
    printf '  "wifi_ssid": "%s",\n' "$(ntool_json_escape "${wifi_ssid:-}")"
    printf '  "wifi_signal": "%s",\n' "$(ntool_json_escape "${wifi_signal:-}")"
    printf '  "dns_servers": '
    printf '%s' "$dns_lines" | ntool_json_array_from_lines
    printf ',\n'
    printf '  "interfaces": '
    printf '%s' "$iface_lines" | ntool_json_array_from_lines
    printf ',\n'
    printf '  "routes": '
    printf '%s' "$route_lines" | ntool_json_array_from_lines
    printf ',\n'
    printf '  "checks": '
    printf '%s' "$check_lines" | ntool_json_array_from_lines
    printf '\n}\n'
}

ntool_watch() {
    local interval="${1:-2}"
    [[ "$interval" =~ ^[0-9]+$ ]] || interval=2
    while true; do
        clear
        ntool_status
        sleep "$interval"
    done
}

ntool_main() {
    local cmd="${1:-}"
    case "$cmd" in
        ''|help|-h|--help)
            ntool_usage
            ;;
        status|summary)
            ntool_status
            ;;
        watch)
            shift
            ntool_watch "${1:-2}"
            ;;
        json)
            ntool_json
            ;;
        ifaces)
            ntool_ifaces
            ;;
        ips)
            ntool_ips
            ;;
        ip)
            shift
            ntool_ip "${1:-}"
            ;;
        devices)
            ntool_devices
            ;;
        public-ip)
            ntool_public_ip4
            printf '\n'
            ;;
        public-ip6)
            ntool_public_ip6
            printf '\n'
            ;;
        routes)
            ntool_routes
            ;;
        gateway)
            ntool_gateway
            printf '\n'
            ;;
        dns)
            ntool_dns
            ;;
        ports)
            ntool_ports
            ;;
        ping)
            shift
            ntool_ping "${1:-}"
            ;;
        resolve)
            shift
            ntool_resolve "${1:-}"
            ;;
        checks|internet)
            ntool_checks
            ;;
        vpn)
            shift
            ntool_vpn_action "$NTOOL_VPN_PROFILE" "${1:-}"
            ;;
        lan)
            shift
            ntool_vpn_action "$NTOOL_LAN_PROFILE" "${1:-}"
            ;;
        ssh)
            shift
            ntool_ssh_action "${1:-}"
            ;;
        ts)
            shift
            ntool_ts_action "${1:-}"
            ;;
        tsd)
            shift
            ntool_tsd_action "${1:-}"
            ;;
        *)
            ntool_err "unknown command: $cmd"
            printf '\n' >&2
            ntool_usage >&2
            return 1
            ;;
    esac
}
