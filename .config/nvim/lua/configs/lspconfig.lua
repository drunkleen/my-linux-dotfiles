-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
    filetypes = { "html", "templ" },
})

lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
    filetypes = { "html", "templ" },
})

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
    },
  },
})

-- Go language server
lspconfig.gopls.setup {
  on_attach = custom_on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go", "gomod", "gowork", "gotmpl"},
  -- root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
      gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparama = true,
      }
    }
  }
}

-- Rust language server setup
lspconfig.rust_analyzer.setup {
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
}