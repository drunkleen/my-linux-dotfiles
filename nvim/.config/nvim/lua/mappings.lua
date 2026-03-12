require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<C-z>", ":qa!<CR>", { noremap = true, silent = true })

pcall(vim.keymap.del, "n", "<leader>\\")
pcall(vim.keymap.del, "t", "<leader>\\")


-----------------------------------------------------------------------
-- Shared helper for horizontal / vertical terminals (same as before)
-----------------------------------------------------------------------
local function toggle_term(name, vertical)
  local bufnr = vim.fn.bufnr(name)

  if bufnr ~= -1 then
    local win = vim.fn.bufwinnr(bufnr)

    if win ~= -1 then
      vim.cmd(win .. "wincmd w")
      vim.cmd("close")
    else
      if vertical then
        vim.cmd("vsplit")
      else
        vim.cmd("botright split | resize 15")
      end
      vim.cmd("buffer " .. bufnr)
    end
  else
    if vertical then
      vim.cmd("vsplit | terminal")
    else
      vim.cmd("botright split | resize 15 | terminal")
    end
    vim.cmd("file " .. name)
  end
end

-- mappings for h / v
map("n", "<leader>h", function() toggle_term("TermH", false) end, { desc = "Toggle Horizontal Terminal" })
map("t", "<leader>h", function() toggle_term("TermH", false) end, { desc = "Toggle Horizontal Terminal (t)" })

map("n", "<leader>v", function() toggle_term("TermV", true) end, { desc = "Toggle Vertical Terminal" })
map("t", "<leader>v", function() toggle_term("TermV", true) end, { desc = "Toggle Vertical Terminal (t)" })

-----------------------------------------------------------------------
-- Floating terminal: single scratch term buffer, true overlay
-----------------------------------------------------------------------
local float_term = { win = nil, buf = nil }

local function open_float_win()
  local ui = vim.api.nvim_list_uis()[1]
  local width  = math.floor(ui.width * 0.8)
  local height = math.floor(ui.height * 0.8)
  local row    = math.floor((ui.height - height) / 2)
  local col    = math.floor((ui.width - width) / 2)

  return vim.api.nvim_open_win(float_term.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    zindex = 50,
  })
end

local function toggle_float_term()
  -- if window is open, just close it
  if float_term.win and vim.api.nvim_win_is_valid(float_term.win) then
    vim.api.nvim_win_close(float_term.win, true)
    float_term.win = nil
    return
  end

  -- ensure we have a terminal buffer
  if not (float_term.buf and vim.api.nvim_buf_is_valid(float_term.buf)) then
    -- create an unlisted, scratch buffer
    float_term.buf = vim.api.nvim_create_buf(false, true)
    float_term.win = open_float_win()
    -- start shell in this buffer
    vim.fn.termopen(vim.o.shell)
  else
    float_term.win = open_float_win()
  end

  vim.cmd("startinsert")
end

-- mappings for floating term
map("n", "<leader>\\", function() toggle_float_term() end, { desc = "Toggle Floating Terminal" })
map("t", "<leader>\\", function() toggle_float_term() end, { desc = "Toggle Floating Terminal (t)" })
