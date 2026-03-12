# dotfiles

Personal Raspberry Pi 5 dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

This `pi5` branch is a compact Debian/Raspberry Pi focused setup centered on:

- Zsh with a structured custom command layer
- tmux with keyboard-heavy pane and session management
- tool/runtime management through `mise`
- terminal utilities such as `btop`, `lazygit`, and `leenfetch`
- Docker-based local service wrappers for development databases
- a standalone `ntool` utility for local network and service inspection

## Repository Layout

Each top-level directory is a Stow package targeted at `~/` via [`.stowrc`](/home/anakin/dotfiles/.stowrc).

Current packages:

- `autostart`
- `btop`
- `lazygit`
- `leenfetch`
- `mise`
- `nvim`
- `shell`
- `tmux`

Example:

```text
shell/.zshrc -> ~/.zshrc
tmux/.config/tmux/tmux.conf -> ~/.config/tmux/tmux.conf
```

## Quick Start

Clone and enter the repo:

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
```

Preview links first:

```bash
stow -n -v */
```

Apply everything:

```bash
stow */
```

Apply only the core shell environment:

```bash
stow shell tmux mise btop lazygit leenfetch autostart
```

Remove one package:

```bash
stow -D shell
```

## What Each Package Does

### `shell`

Main interactive environment:

- Zsh with Oh My Zsh, Powerlevel10k, `mise activate zsh`, and `leenfetch` on shell startup
- grouped aliases, functions, theme variables, and completions
- local binaries under `~/.local/bin`
- Git identity defaults from [`.gitconfig`](/home/anakin/dotfiles/shell/.gitconfig)

Important files:

- [shell/.zshrc](/home/anakin/dotfiles/shell/.zshrc)
- [shell/.config/shell/.alias](/home/anakin/dotfiles/shell/.config/shell/.alias)
- [shell/.config/shell/aliases.d/10-navigation.zsh](/home/anakin/dotfiles/shell/.config/shell/aliases.d/10-navigation.zsh)
- [shell/.config/shell/aliases.d/20-editor.zsh](/home/anakin/dotfiles/shell/.config/shell/aliases.d/20-editor.zsh)
- [shell/.config/shell/aliases.d/30-containers.zsh](/home/anakin/dotfiles/shell/.config/shell/aliases.d/30-containers.zsh)
- [shell/.config/shell/functions.d](/home/anakin/dotfiles/shell/.config/shell/functions.d)
- [shell/.config/shell/ntool/ntool](/home/anakin/dotfiles/shell/.config/shell/ntool/ntool)

#### Shell aliases

- `ls`, `l`, `ll`, `ld`, `lt` use `eza`
- `lz` falls back to plain `ls`
- `c`, `cls` clear the terminal
- `..`, `...`, `.3`, `.4`, `.5` move up directory levels
- `mkdir` is always `mkdir -p`
- `vc` opens VS Code
- `vim` maps to `nvim`
- `cat` maps to `bat`
- `docker` maps to `sudo docker`

#### Shell functions

General:

- `open <path-or-url>` opens via `xdg-open`
- `opendir [path]` opens Nautilus or falls back to `open`
- `shellhelp` prints the command catalog

Package management:

- `update` runs the repo package update flow
- `pkg update`
- `pkg install <package...>`
- `pkg remove <package...>`
- `pkg remove-deps <package...>`
- `pkg search <query>`
- `pkg list`
- `pkg info <package...>`

Project bootstrapping:

- `initmvn <name>` creates a Maven quickstart project, `.env`, and `.gitignore`
- `initgo <name>` creates a Go module, `main.go`, `.env`, and `.gitignore`

Notifications and networking:

- `send-notif <message>` sends a message to the configured `ntfy.sh` topic
- `iporigin <ip|domain|url>` resolves a target and shows geo/IP ownership info
- `ips` prints local IPv4/IPv6 addresses and public IPs

Docker helpers:

- `dockerstart`
- `dockerstop`
- `dockerlist`

Database/service wrappers:

- `postgres up|down|status|config|recreate`
  - manages PostgreSQL plus pgAdmin
  - supports custom image, port, database, user, password, and pgAdmin settings
- `mongo up|down|status|config|recreate`
- `redis up|down|status|config|recreate`
- `searx up|down|status|config|recreate`

### `ntool`

`ntool` is installed from [shell/.local/bin/ntool](/home/anakin/dotfiles/shell/.local/bin/ntool) and implemented under [shell/.config/shell/ntool](/home/anakin/dotfiles/shell/.config/shell/ntool).

It provides local network and service operations:

- `ntool status` or `ntool summary`
- `ntool watch [seconds]`
- `ntool json`
- `ntool ifaces`
- `ntool ips`
- `ntool ip <iface>`
- `ntool devices`
- `ntool routes`
- `ntool gateway`
- `ntool dns`
- `ntool public-ip`
- `ntool public-ip6`
- `ntool ports`
- `ntool ping <host>`
- `ntool resolve <host>`
- `ntool checks`

Service control through `systemd`, WireGuard, and Tailscale:

- `ntool vpn on|off|status`
- `ntool lan on|off|status`
- `ntool ssh on|off|restart|status|enable|disable|port`
- `ntool ts on|off|status|ip|peers`
- `ntool tsd on|off|enable|disable`

## Other Packages

### `tmux`

[tmux/.config/tmux/tmux.conf](/home/anakin/dotfiles/tmux/.config/tmux/tmux.conf) sets:

- `C-Space` as the main prefix, with `C-b` kept as secondary
- vi copy mode bindings
- split panes in the current working directory
- `Alt` window switching and `Ctrl+Alt` pane navigation
- top status bar, mouse support, RGB colors, renumbered windows, and clipboard integration

### `mise`

[mise/.config/mise/config.toml](/home/anakin/dotfiles/mise/.config/mise/config.toml) installs and manages:

- `air`
- `bat`
- `docker-compose`
- `fzf`
- `go`
- `gofumpt`
- `java`
- `maven`
- `node`
- `pipx`
- `python`
- `rust`
- `rust-analyzer`
- `tmux`
- `yazi`
- `zig`
- `zls`

### `btop`

[btop/.config/btop/btop.conf](/home/anakin/dotfiles/btop/.config/btop/btop.conf) enables:

- custom `current` theme
- vim-style navigation
- CPU, memory, network, and process panels
- temperature, uptime, swap, disks, and battery display

### `leenfetch`

[leenfetch/.config/leenfetch/config.jsonc](/home/anakin/dotfiles/leenfetch/.config/leenfetch/config.jsonc) defines a custom multi-section fetch layout for:

- system information
- hardware information
- OS age and uptime

### `lazygit`

[lazygit/.config/lazygit/config.yml](/home/anakin/dotfiles/lazygit/.config/lazygit/config.yml) is tracked for user overrides. It is currently empty.

### `autostart`

[autostart/.config/autostart/pi-apps-updater.desktop](/home/anakin/dotfiles/autostart/.config/autostart/pi-apps-updater.desktop) auto-starts the Pi-Apps updater on login.

### `nvim`

The `nvim` Stow package exists, but there are currently no tracked Neovim config files inside [nvim/.config/nvim](/home/anakin/dotfiles/nvim/.config/nvim).

## Dependencies and Assumptions

This branch assumes a Debian/Raspberry Pi environment with most of the following available:

- `stow`
- `zsh`
- `oh-my-zsh`
- `powerlevel10k`
- `mise`
- `eza`
- `bat`
- `curl`
- `jq`
- `docker`
- `systemd`
- `tmux`
- `btop`
- `leenfetch`
- `code` and optionally `nautilus`

Some functions also depend on:

- `mvn` for `initmvn`
- `go` for `initgo`
- `wg` / `wg-quick` for WireGuard controls
- `tailscale` for Tailscale controls
- `nmcli` or `iwgetid` for Wi-Fi details

## Typical Workflow

```bash
stow shell tmux mise
exec zsh
shellhelp
ntool status
pkg update
postgres up
```
