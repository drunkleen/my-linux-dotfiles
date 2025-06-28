require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

vim.g.copilot_no_tab_map = true
map("i", "<C-y>", "copilot#Accept()",
    { expr = true,
    silent = true,
    replace_keycodes = false,
    desc = "Accept Copilot suggestion" }
)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
