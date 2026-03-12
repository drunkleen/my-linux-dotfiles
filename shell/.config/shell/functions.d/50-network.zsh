iporigin() {
  local input target host ip info

  (( $# )) || shell_fail "Usage: iporigin <ip|domain|url>" || return 1
  shell_need curl || return 1
  shell_need jq || return 1
  shell_need getent || return 1

  input="$1"
  target="$input"

  if [[ "$input" =~ ^[a-zA-Z][a-zA-Z0-9+.-]*:// ]]; then
    target="${input#*://}"
    target="${target%%/*}"
  fi

  target="${target#*@}"

  if [[ "$target" =~ ^\[.*\](:[0-9]+)?$ ]]; then
    host="${target#[}"
    host="${host%%]*}"
  else
    host="${target%%:*}"
  fi

  if [[ "$host" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || [[ "$host" == *:* ]]; then
    ip="$host"
  else
    ip="$(getent ahosts "$host" | awk '{print $1}' | head -n 1)"
    [[ -n "$ip" ]] || shell_fail "Could not resolve host: $host" || return 1
  fi

  info="$(curl -fsS "http://ip-api.com/json/${ip}")"
  echo "Input:   $input"
  echo "Host:    $host"
  echo "IP:      $ip"
  echo "Country: $(echo "$info" | jq -r '.country')"
  echo "Region:  $(echo "$info" | jq -r '.regionName')"
  echo "City:    $(echo "$info" | jq -r '.city')"
  echo "ISP:     $(echo "$info" | jq -r '.isp')"
  echo "ASN:     $(echo "$info" | jq -r '.as')"
}

ips() {
  local hide_re='^(br-|veth|virbr|podman|tun|tap)'
  local pub4 pub6

  shell_need ip || return 1
  shell_need curl || return 1

  echo "Local IPv4"
  ip -o -4 addr show up \
    | awk -v re="$hide_re" '$2 !~ re { print $2, $4 }' \
    | sort -k1,1

  echo
  echo "Local IPv6"
  ip -o -6 addr show up scope global 2>/dev/null \
    | awk -v re="$hide_re" '$2 !~ re { print $2, $4 }' \
    | sort -k1,1

  pub4="$(curl -4fsS --max-time 3 https://ifconfig.co 2>/dev/null || true)"
  pub6="$(curl -6fsS --max-time 3 https://ifconfig.co 2>/dev/null || true)"

  echo
  echo "Public IPv4: ${pub4:-not available}"
  echo "Public IPv6: ${pub6:-not available}"
}
