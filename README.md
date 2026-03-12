# dotfiles

Personal Linux dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

This repository is built around a Wayland desktop workflow with Hyprland, a structured Zsh shell setup, tmux, Neovim, and a small layer of custom shell utilities.

## What This Repo Covers

- Stow-managed home-directory packages
- Hyprland desktop configuration and companion Wayland tools
- Zsh shell setup with grouped aliases, functions, completions, and theming
- tmux configuration under `~/.config/tmux/tmux.conf`
- Neovim, terminal, notification, launcher, and status bar configs
- Small operational helpers such as:
  - `shellhelp`
  - `ntool`
  - `pkg` / `aur` / `update`
  - `postgres` / `mongo` / `redis` / `searx`

## Repository Model

Each top-level directory is a Stow package.

The repository uses this Stow target:

```text
~/
```

That comes from [`.stowrc`](/home/snape/dotfiles/.stowrc):

```text
--target=~
--verbose
--restow
```

In practice, a package such as:

```text
shell/.zshrc
```

is linked to:

```text
~/.zshrc
```

## Top-Level Packages

Current packages in this repo:

- `alacritty`
- `autostart`
- `btop`
- `elephant`
- `fontconfig`
- `ghostty`
- `hypr`
- `hyprland-preview-share-picker`
- `kitty`
- `lazygit`
- `leenfetch`
- `mako`
- `mise`
- `nvim`
- `nwg-displays`
- `shell`
- `tmux`
- `uwsm`
- `walker`
- `waybar`

## Key Paths

Important package entrypoints:

- [shell](/home/snape/dotfiles/shell)
  - [`.zshrc`](/home/snape/dotfiles/shell/.zshrc)
  - [`.config/shell/.alias`](/home/snape/dotfiles/shell/.config/shell/.alias)
  - [`.config/shell/aliases.d`](/home/snape/dotfiles/shell/.config/shell/aliases.d)
  - [`.config/shell/functions.d`](/home/snape/dotfiles/shell/.config/shell/functions.d)
  - [`.config/shell/completions`](/home/snape/dotfiles/shell/.config/shell/completions)
  - [`.config/shell/ntool`](/home/snape/dotfiles/shell/.config/shell/ntool)
- [tmux](/home/snape/dotfiles/tmux)
  - [`.config/tmux/tmux.conf`](/home/snape/dotfiles/tmux/.config/tmux/tmux.conf)
- [hypr](/home/snape/dotfiles/hypr)
- [waybar](/home/snape/dotfiles/waybar)
- [walker](/home/snape/dotfiles/walker)
- [nvim](/home/snape/dotfiles/nvim)
- [kitty](/home/snape/dotfiles/kitty)
- [ghostty](/home/snape/dotfiles/ghostty)
- [alacritty](/home/snape/dotfiles/alacritty)

## Quick Start

Clone into `~/dotfiles`:

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

Dry-run first:

```bash
stow -n -v */
```

Apply everything:

```bash
stow */
```

Or start with a smaller set:

```bash
stow shell tmux nvim kitty
stow hypr waybar walker uwsm mako
```

## Updating Links

Re-apply all links after changes:

```bash
stow */
```

Re-apply only one package:

```bash
stow shell
```

Remove one package’s links:

```bash
stow -D shell
```

Preview changes without touching the filesystem:

```bash
stow -n -v shell
```

## Conflict Handling

If Stow reports an existing file or directory in `$HOME`, move it out of the way first.

Examples:

```bash
mv ~/.zshrc ~/.zshrc.bak
stow shell
```

```bash
mv ~/.config/nvim ~/.config/nvim.bak
stow nvim
```

## Shell Layer

The shell configuration is intentionally structured instead of keeping everything in one monolithic file.

Layout:

- [`.config/shell/.alias`](/home/snape/dotfiles/shell/.config/shell/.alias)
  - bootstrap file
  - sets completion path
  - loads theme, aliases, and functions
- [`.config/shell/theme.zsh`](/home/snape/dotfiles/shell/.config/shell/theme.zsh)
  - shared color/icon variables
- [`.config/shell/aliases.d`](/home/snape/dotfiles/shell/.config/shell/aliases.d)
  - lightweight aliases
- [`.config/shell/functions.d`](/home/snape/dotfiles/shell/.config/shell/functions.d)
  - public shell commands
- [`.config/shell/completions`](/home/snape/dotfiles/shell/.config/shell/completions)
  - zsh completions for custom commands

Useful shell commands:

- `shellhelp`
  - prints the custom command catalog
- `update`
  - updates repo packages and AUR packages
- `pkg ...`
  - repo package commands
- `aur ...`
  - AUR package commands
- `postgres ...`, `mongo ...`, `redis ...`, `searx ...`
  - container service commands
- `ntool`
  - local network/service utility

## Package Commands

Repo package commands:

```bash
pkg update
pkg install <pkg>
pkg remove <pkg>
pkg remove-deps <pkg>
pkg search <query>
pkg list
pkg info <pkg>
pkg help
```

AUR commands:

```bash
aur update
aur install <pkg>
aur remove <pkg>
aur remove-deps <pkg>
aur search <query>
aur list
aur info <pkg>
aur help
```

Combined update:

```bash
update
```

## Container Commands

Docker engine helpers:

```bash
dockerstart
dockerstop
dockerlist
```

Service-oriented helpers:

```bash
postgres up|down|status|config|recreate|help
mongo up|down|status|config|recreate|help
redis up|down|status|config|recreate|help
searx up|down|status|config|recreate|help
```

Examples:

```bash
postgres up
postgres status
postgres recreate --user snape --password secret --db app --port 5433

redis up
redis config
redis recreate --port 6380

mongo up
searx help
```

Note:

- `recreate` removes and rebuilds the container
- non-persistent data inside the container is lost unless you mount volumes yourself

## `ntool`

`ntool` is a Bash-based command utility under:

- [`.config/shell/ntool/ntool`](/home/snape/dotfiles/shell/.config/shell/ntool/ntool)
- [`.local/bin/ntool`](/home/snape/dotfiles/shell/.local/bin/ntool)

It is split into focused modules inside:

- [`.config/shell/ntool/lib`](/home/snape/dotfiles/shell/.config/shell/ntool/lib)

Typical usage:

```bash
ntool help
ntool status
ntool ifaces
ntool routes
ntool dns
ntool checks
ntool ts status
```

## tmux

tmux is configured from:

- [tmux.conf](/home/snape/dotfiles/tmux/.config/tmux/tmux.conf)

Current behavior includes:

- `zsh` as the default shell
- `C-Space` as the main prefix
- vi-style copy mode
- pane navigation with `Ctrl+Alt+Arrow`
- top status bar
- base index `1`

Reload tmux config:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

## Prerequisites

Core requirements:

- `git`
- `stow`
- `zsh`

Common tools referenced by the configs:

- `tmux`
- `neovim`
- `kitty`, `ghostty`, or `alacritty`
- `hyprland`
- `waybar`
- `walker`
- `uwsm`
- `mako`
- `mise`
- `eza`
- `bat`
- `jq`
- `ripgrep`
- `fzf`
- `docker`
- `yay` for AUR helpers

## Maintenance Notes

- After changing shell functions, aliases, completions, or theme files:

```bash
source ~/.zshrc
```

- After changing a stowed package layout:

```bash
stow shell
```

- If zsh completion behaves strangely, rebuild the completion cache:

```bash
rm -f ~/.zcompdump*
autoload -Uz compinit && compinit
source ~/.zshrc
```

## Scope

This repo is Linux-first and optimized for a personal Wayland workflow.

It is opinionated, not a generic starter template.

## License

Personal dotfiles repository. Reuse freely with attribution.
