# My Linux Configs 🐧

A collection of my personal Linux configuration files, focusing on creating a powerful and efficient development environment.

## Overview 📝

This repository contains my personal Linux configuration files (dotfiles) for various tools and applications I use daily. The setup is primarily focused on Arch Linux with ZSH shell.

### Features ✨

- **ZSH Configuration**: Enhanced shell experience with Oh-my-zsh and Powerlevel10k theme
- **TMUX Setup**: Advanced terminal multiplexer configuration with custom keybindings and plugins
- **VSCode Profiles**: Custom Visual Studio Code settings
- **Custom Aliases**: Extensive collection of useful aliases for daily tasks
- **Arch Linux Specific**: Optimized for Arch Linux with package management helpers

## Components 🔧

- `.zshrc` - ZSH shell configuration
- `.tmux.conf` - Tmux configuration
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.alias` - Custom aliases
- `vscode_profiles/` - VSCode settings
- `.config/` - Various application configs

## Prerequisites 📋

- Arch Linux (or other Linux distributions)
- ZSH shell
- Oh-my-zsh
- Tmux
- Powerlevel10k theme
- Various ZSH plugins (listed in .zshrc)

## Installation 🚀

1. Clone this repository:
```bash
git clone https://github.com/yourusername/my-linux-configs.git
```

2. Create symbolic links to your home directory:
```bash
cd my-linux-configs
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.p10k.zsh ~/.p10k.zsh
# ... create other symlinks as needed
```

## Key Features 🔑

### Shell Enhancements
- Automatic package suggestion for unknown commands
- Integrated AUR helper detection (yay/paru)
- Custom package installation function
- Powerful command-line completion
- Syntax highlighting
- Auto-suggestions based on command history

### TMUX Configuration
- Vim-like keybindings
- Catppuccin theme integration
- Custom status bar with system information
- Battery and CPU monitoring
- Wayland clipboard integration
- Easy window and pane navigation

### Custom Aliases and Functions
- Extensive collection of aliases for common operations
- Git shortcuts
- System maintenance commands
- Package management helpers
- Development workflow optimizations

### Additional Features
- Neofetch system information display
- NVM (Node Version Manager) integration
- Custom VSCode profiles
- Wayland-specific configurations
- FZF (Fuzzy Finder) integration

## Directory Structure 📁

```
.
├── .config/         # Application-specific configurations
├── .tmux/          # TMUX plugins and settings
├── vscode_profiles/ # VSCode configuration profiles
├── .zshrc          # ZSH shell configuration
├── .tmux.conf      # TMUX configuration
├── .p10k.zsh       # Powerlevel10k theme settings
├── .alias          # Custom aliases
├── .zprofile       # ZSH profile settings
├── .zshenv         # ZSH environment variables
└── .profile        # General profile settings
```

## Usage Tips 💡

1. **Package Management**:
   - Use `in` command to install packages (automatically detects AUR/official repos)
   - Package suggestions for unknown commands

2. **TMUX**:
   - Start automatically with shell
   - Use `Ctrl+b` as prefix key
   - Vim-style navigation between panes
   - Mouse support (disabled by default)

3. **ZSH Features**:
   - Smart command completion
   - Git status in prompt
   - Directory navigation shortcuts
   - Command history search with fuzzy finding

## Customization 🎨

You can customize these configurations by:
1. Modifying the respective dotfiles
2. Adding new aliases to `.alias`
3. Adjusting TMUX settings in `.tmux.conf`
4. Modifying ZSH plugins in `.zshrc`
5. Customizing the Powerlevel10k theme via `p10k configure`

## Troubleshooting 🔧

Common issues and solutions:
1. If colors aren't displaying correctly, ensure your terminal supports 256 colors
2. For font issues, install and configure a Nerd Font
3. For TMUX plugin issues, ensure TPM (TMUX Plugin Manager) is installed
4. For ZSH plugin issues, verify Oh-my-zsh installation and plugin paths

## Contributing 🤝

Feel free to fork this repository and customize it for your needs. If you have any improvements or suggestions, pull requests are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📄

This project is open source and available under the MIT License.

## Acknowledgments 👏

- Oh-my-zsh community
- Powerlevel10k theme developers
- TMUX plugin developers
- Arch Linux community

---

**Note**: Remember to backup your existing dotfiles before installing these configurations!
