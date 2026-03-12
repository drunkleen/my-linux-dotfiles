require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "pyright",
  "clangd",        -- C/C++
  "bashls",        -- bash/sh
  "autotools_ls",  -- make/autotools
}
vim.lsp.enable(servers)

-- -------------------
--   pyright (Python)
-- -------------------
vim.lsp.config("pyright", {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",      -- "off" | "basic" | "strict"
        autoImportCompletions = true,
      },
    },
  },
})


-- -------------------
--   clangd (C/C++)
-- -------------------
vim.lsp.config("clangd", {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,
})


-- -------------------
--   bashls (Bash)
-- -------------------
vim.lsp.config("bashls", {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,
})


-- -------------------
--   autotools_ls (Makefile/Autotools)
-- -------------------
vim.lsp.config("autotools_ls", {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,
})


-- -------------------
--   rust_analyzer
-- -------------------
vim.lsp.config('rust_analyzer', {
  on_attach = custom_on_attach,
  on_init = on_init,
  capabilities = capabilities,

  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
})


-- -------------------
--   enable all servers
-- -------------------
vim.lsp.enable(servers)
vim.lsp.enable("rust_analyzer")
