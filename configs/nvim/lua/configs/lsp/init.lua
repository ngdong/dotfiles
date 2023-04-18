local M = {}

-- local util = require "lspconfig.util"

local servers = {
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  pyright = {
    analysis = {
      typeCheckingMode = "off",
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true
        },
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  },
  lua_ls= {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
          disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          -- library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        completion = { callSnippet = "Both" },
        telemetry = { enable = false },
      },
    },
  },
  tsserver = { disable_formatting = true },
  vimls = {},
  tailwindcss = {},
  yamlls = {},
  dockerls = {},
  graphql = {},
  bashls = {},
  omnisharp = {},
  kotlin_language_server = {},
  emmet_ls = {},
  marksman = {},
  angularls = {},
  vls={},
}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("configs.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  require("configs.lsp.highlighter").setup(client)

  -- Configure formatting
  require("configs.lsp.null-ls.formatters").setup(client, bufnr)

  -- tagfunc
  if client.server_capabilities.definitionProvider then
    vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  end

  -- nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    local navic = require "nvim-navic"
    navic.attach(client, bufnr)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = require("cmp_nvim_lsp").default_capabilities() -- for nvim-cmp

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("configs.lsp.handlers").setup()

function M.setup()
  -- null-ls
  require("configs.lsp.null-ls").setup(opts)

  -- Installer
  require("configs.lsp.installer").setup(servers, opts)
end

local diagnostics_active = true

function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

function M.remove_unused_imports()
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
  vim.cmd "packadd cfilter"
  vim.cmd "Cfilter /main/"
  vim.cmd "Cfilter /The import/"
  vim.cmd "cdo normal dd"
  vim.cmd "cclose"
  vim.cmd "wa"
end

return M
