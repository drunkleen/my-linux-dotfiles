# NvChad config

Personal NvChad setup with ayu_dark theme, dashboard, WakaTime, conform.nvim formatting, LSP, and Yazi file manager integration.

## Requirements
- Neovim 0.9+ and Git
- Ripgrep (`rg`) for Telescope search
- Yazi binary if you want the terminal file manager integration
- WakaTime account/api key to record time

## Install
1) Back up any existing config: `mv ~/.config/nvim ~/.config/nvim.bak`
2) Clone this repo into `~/.config/nvim`: `git clone <this-repo-url> ~/.config/nvim`
3) Start Neovim: `nvim` (Lazy will sync plugins on first start)
4) For WakaTime, make sure `~/.wakatime.cfg` has your API key.

## Key maps

### Custom mappings (`lua/mappings.lua`)
Mode | Keys | Action
---|---|---
Normal | `;` | Enter command-line
Insert | `jk` | Exit insert
Normal | `<C-z>` | Quit all without saving (`:qa!`)
Normal/Insert/Visual | `<C-s>` | Save file (currently commented out; uncomment in `lua/mappings.lua` to enable)

### NvChad defaults (core)
Mode | Keys | Action
---|---|---
Insert | `<C-b>` | Jump to start of line
Insert | `<C-e>` | Jump to end of line
Insert | `<C-h>/<C-l>/<C-j>/<C-k>` | Move left/right/down/up
Normal | `<C-h>/<C-l>/<C-j>/<C-k>` | Window focus left/right/down/up
Normal | `<Esc>` | Clear search highlights
Normal | `<C-s>` | Save file
Normal | `<C-c>` | Copy whole buffer to system clipboard
Normal | `<leader>n` | Toggle absolute line numbers
Normal | `<leader>rn` | Toggle relative line numbers
Normal | `<leader>ch` | Open NvChad cheatsheet
Normal/Visual | `<leader>fm` | Format (conform.nvim, LSP fallback)
Normal | `<leader>ds` | Show diagnostics in location list
Normal | `<leader>b` | New buffer (tabufline enabled only)
Normal | `<Tab>/<S-Tab>` | Next/previous buffer (tabufline)
Normal | `<leader>x` | Close buffer (tabufline)
Normal | `<leader>/` | Toggle comment (Comment.nvim)
Visual | `<leader>/` | Toggle comment on selection
Normal | `<C-n>` | Toggle NvimTree
Normal | `<leader>e` | Focus NvimTree
Normal | `<leader>ff` | Telescope find files
Normal | `<leader>fa` | Telescope find all (includes hidden)
Normal | `<leader>fw` | Telescope live grep
Normal | `<leader>fb` | Telescope buffers
Normal | `<leader>fh` | Telescope help tags
Normal | `<leader>ma` | Telescope marks
Normal | `<leader>fo` | Telescope old files
Normal | `<leader>fz` | Telescope fuzzy find in current buffer
Normal | `<leader>cm` | Telescope git commits
Normal | `<leader>gt` | Telescope git status
Normal | `<leader>pt` | Telescope terminals picker
Normal | `<leader>th` | NvChad theme picker
Terminal | `<C-x>` | Exit terminal mode
Normal | `<leader>h` | New horizontal terminal
Normal | `<leader>v` | New vertical terminal
Normal/Terminal | `<A-v>` | Toggle vertical terminal
Normal/Terminal | `<A-h>` | Toggle horizontal terminal
Normal/Terminal | `<A-i>` | Toggle floating terminal
Normal | `<leader>wK` | Show WhichKey for all mappings
Normal | `<leader>wk` | Query WhichKey for specific prefix

### Alpha dashboard buttons
Mode | Keys | Action
---|---|---
Dashboard | `f` | Find file (Telescope)
Dashboard | `g` | Live grep (Telescope)
Dashboard | `r` | Recent files
Dashboard | `e` | File explorer (NvimTree)
Dashboard | `c` | Open this config
Dashboard | `u` | Update NvChad
Dashboard | `h` | NvCheatsheet
Dashboard | `m` | Mason
Dashboard | `q` | Quit Neovim

### Yazi file manager
Mode | Keys | Action
---|---|---
Normal | `<leader>-` | Open Yazi file manager
Normal | `<leader>cw` | Open Yazi in current working dir
Normal | `<C-Up>` | Resume last Yazi session

## Notes
- NvChad itself is pulled as a plugin; user config lives here in `lua/`.
- You can remove the `.git` folder if you prefer to track your own fork.
