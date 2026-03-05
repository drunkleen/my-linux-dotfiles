# dotfiles

Personal Linux dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/), centered on an Arch + Omarchy + Hyprland workflow.

## Highlights

- Stow-managed, package-per-directory layout
- Hyprland desktop setup with Omarchy integration (`hypr`, `waybar`, `walker`, `uwsm`, etc.)
- Shell stack with Zsh + Oh My Zsh + Powerlevel10k + Starship + mise
- Editor setup based on NvChad (`nvim`)
- Terminal configs for Kitty, Alacritty, and Ghostty

## Repository layout

Each top-level folder is a Stow package. Files inside are mirrored into `$HOME` (target is set in `.stowrc`).

Notable packages:

- `zsh` -> `~/.zshrc`, `~/.zshenv`, `~/.alias`, `~/.oh-my-zsh`, `~/.p10k.zsh`
- `tmux` -> `~/.tmux.conf`, `~/.tmux/...`
- `nvim` -> `~/.config/nvim/...`
- `hypr` -> `~/.config/hypr/...`
- `waybar` -> `~/.config/waybar/...`
- `walker` -> `~/.config/walker/...`
- `kitty`, `alacritty`, `ghostty` -> terminal configs
- `mise` -> `~/.config/mise/config.toml`
- `starship.toml` -> `~/.config/starship.toml`
- `yazi`, `lazygit`, `lazydocker`, `btop`, `fcitx5`, `qt6ct`, `fontconfig`, etc.

## Prerequisites

- `stow`
- Git
- A Nerd Font (configs use `CaskaydiaMono Nerd Font`)
- Core tools referenced by configs: `zsh`, `tmux`, `neovim`, `kitty`/`alacritty`/`ghostty`, `hyprland`, `waybar`, `walker`, `uwsm`, `mise`, `wl-clipboard`, `ripgrep`, `jq`, `bc`, `fzf`
- Omarchy installed (many desktop configs reference `~/.local/share/omarchy/...`)

## Quick start

```bash
git clone https://github.com/drunkleen/my-linux-dotfiles.git ~/dotfiles
cd ~/dotfiles

# Dry-run first (recommended)
stow -n -v */

# Apply links (uses .stowrc: --target=~ --restow --verbose)
stow */
```

Or stow only selected packages first:

```bash
stow zsh tmux nvim
stow hypr waybar walker uwsm
stow kitty alacritty ghostty
```

## Daily commands

```bash
# Re-apply links after edits/new files
stow */

# Re-apply only one package
stow zsh

# Remove links created by one package
stow -D zsh

# Simulate operations without changing files
stow -n -v zsh
```

## Conflict handling

If Stow reports an existing file conflict in `$HOME`, back it up first:

```bash
mv ~/.zshrc ~/.zshrc.bak
stow zsh
```

For directories:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
stow nvim
```

## Package inventory

Current Stow packages in this repo:

`alacritty btop fcitx5 fontconfig ghostty git gtk-3.0 hypr hyprland-preview-share-picker hyprpanel imv kitty lazydocker lazygit leenfetch mako mimeapps.list mise mpv nvim nwg-displays qt6ct starship.toml tmux uwsm walker waybar yazi zsh`

## Notes

- This setup is Linux-first and optimized for Wayland/Hyprland.
- `nvim` is an NvChad-based config.
- The repository includes vendored content such as `~/.oh-my-zsh` and tmux plugin directories.
- Some packages may currently be placeholders with no tracked files yet (for future expansion).

## License

For personal use. Reuse freely with attribution.
