-- lua/plugins/alpha.lua

return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,       -- load on startup (important for dashboard)
    priority = 1000,    -- make sure it loads early

    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        "██      ███████ ███████ ███    ██ ██ ██    ██ ███    ███",
        "██      ██      ██      ████   ██ ██ ██    ██ ████  ████",
        "██      █████   █████   ██ ██  ██ ██ ██    ██ ██ ████ ██",
        "██      ██      ██      ██  ██ ██ ██ ██    ██ ██  ██  ██",
        "███████ ███████ ███████ ██   ████ ██  ██████  ██      ██",
      }

      -- Buttons
      dashboard.section.buttons.val = {
        -- Files & search (Telescope is built into NvChad)
        dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("g", "󰺯  Live Grep", ":Telescope live_grep<CR>"),
        dashboard.button("r", "󰄉  Recent Files", ":Telescope oldfiles<CR>"),

        -- File explorer (NvChad uses nvim-tree by default; change to Neotree if you use that)
        dashboard.button("e", "󰙅  File Explorer", ":NvimTreeToggle<CR>"),
        -- or if you really use Neo-tree:
        -- dashboard.button("e", "󰙅  File Explorer", ":Neotree toggle<CR>"),

        -- NvChad-specific commands
        dashboard.button("c", "  NvChad Config", ":e ~/.config/nvim/lua/chadrc.lua<CR>"),
        dashboard.button("u", "󰚰  NvChad Update", ":NvChadUpdate<CR>"),
        dashboard.button("h", "󰋖  Cheatsheet", ":NvCheatsheet<CR>"),
        dashboard.button("m", "  Mason", ":Mason<CR>"),

        -- Quit
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      -- Footer
      dashboard.section.footer.val = "🚀 Ready to build something awesome!"
      dashboard.section.footer.opts.hl = "Type"

      -- Setup alpha
      alpha.setup(dashboard.opts)

    end,
  },
}
