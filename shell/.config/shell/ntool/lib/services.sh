#!/usr/bin/env bash

ntool_systemd_active() {
    systemctl is-active --quiet "$1" >/dev/null 2>&1
}

ntool_systemd_enabled() {
    systemctl is-enabled --quiet "$1" >/dev/null 2>&1
}

ntool_wireguard_state() {
    local profile="$1"
    if ! ntool_has wg; then
        printf 'unavailable'
    elif sudo -n wg show "$profile" >/dev/null 2>&1; then
        printf 'active'
    else
        printf 'inactive'
    fi
}

ntool_tailscale_state() {
    if ! ntool_has tailscale; then
        printf 'unavailable'
    elif tailscale status 2>/dev/null | sed -n '1p' >/dev/null; then
        if tailscale status 2>/dev/null | awk 'NR==1 {exit 0}'; then
            printf 'active'
        else
            printf 'inactive'
        fi
    else
        printf 'inactive'
    fi
}

ntool_tailscaled_state() {
    if ! ntool_has tailscale; then
        printf 'unavailable'
    elif ntool_has systemctl && ntool_systemd_active tailscaled; then
        printf 'active'
    elif pgrep -x tailscaled >/dev/null 2>&1; then
        printf 'active'
    else
        printf 'inactive'
    fi
}

ntool_ssh_state() {
    if ntool_systemd_active sshd; then
        printf 'active'
    else
        printf 'inactive'
    fi
}

ntool_ssh_port() {
    if [[ -f /etc/ssh/sshd_config ]]; then
        awk '
            /^[[:space:]]*#/ { next }
            tolower($1) == "port" { port=$2 }
            END { if (port == "") print "22"; else print port }
        ' /etc/ssh/sshd_config 2>/dev/null
    else
        printf '22\n'
    fi
}

ntool_vpn_action() {
    local profile="$1" action="${2:-}"

    case "$action" in
        on)
            if ! ntool_has wg-quick; then
                ntool_err 'wg-quick is not installed'
                return 1
            fi
            if sudo wg show "$profile" >/dev/null 2>&1; then
                ntool_info "WireGuard profile '$profile' is already active."
                return 0
            fi
            sudo wg-quick up "$profile"
            ;;
        off)
            if ! ntool_has wg-quick; then
                ntool_err 'wg-quick is not installed'
                return 1
            fi
            if ! sudo wg show "$profile" >/dev/null 2>&1; then
                ntool_info "WireGuard profile '$profile' is already inactive."
                return 0
            fi
            sudo wg-quick down "$profile"
            ;;
        status)
            if ! ntool_has wg; then
                ntool_err 'wg is not installed'
                return 1
            fi
            sudo wg show "$profile"
            ;;
        *)
            if [[ "$profile" == "$NTOOL_VPN_PROFILE" ]]; then
                ntool_err 'usage: ntool vpn on|off|status'
            else
                ntool_err 'usage: ntool lan on|off|status'
            fi
            return 1
            ;;
    esac
}

ntool_ssh_action() {
    local action="${1:-}"
    case "$action" in
        on) sudo systemctl start sshd ;;
        off) sudo systemctl stop sshd ;;
        restart) sudo systemctl restart sshd ;;
        status)
            printf 'SSH run: %s\n' "$(ntool_ssh_state)"
            printf 'SSH boot: %s\n' "$(if ntool_systemd_enabled sshd; then printf 'enabled'; else printf 'disabled'; fi)"
            printf 'SSH port: %s\n' "$(ntool_ssh_port)"
            ;;
        enable) sudo systemctl enable sshd ;;
        disable) sudo systemctl disable sshd ;;
        port) ntool_ssh_port ;;
        *)
            ntool_err 'usage: ntool ssh on|off|restart|status|enable|disable|port'
            return 1
            ;;
    esac
}

ntool_ts_action() {
    local action="${1:-}"
    case "$action" in
        on)
            if ! ntool_has tailscale; then
                ntool_err 'tailscale is not installed'
                return 1
            fi
            if ntool_has systemctl && ! ntool_systemd_active tailscaled; then
                sudo systemctl start tailscaled
            fi
            sudo tailscale up
            ;;
        off)
            if ! ntool_has tailscale; then
                ntool_err 'tailscale is not installed'
                return 1
            fi
            sudo tailscale down
            ;;
        status)
            tailscale status
            ;;
        ip)
            tailscale ip
            ;;
        peers)
            tailscale status | sed '1d'
            ;;
        *)
            ntool_err 'usage: ntool ts on|off|status|ip|peers'
            return 1
            ;;
    esac
}

ntool_tsd_action() {
    local action="${1:-}"
    case "$action" in
        on) sudo systemctl start tailscaled ;;
        off) sudo systemctl stop tailscaled ;;
        enable) sudo systemctl enable tailscaled ;;
        disable) sudo systemctl disable tailscaled ;;
        *)
            ntool_err 'usage: ntool tsd on|off|enable|disable'
            return 1
            ;;
    esac
}
