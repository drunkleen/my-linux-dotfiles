require "nvchad.autocmds"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "rs" },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4

    vim.bo.cindent = true

    vim.bo.cinoptions = "l1,g0,(0,W4"
  end,
})



vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 2000,
    })
  end,
})

