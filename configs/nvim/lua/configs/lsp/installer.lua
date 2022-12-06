local M = {}

function M.setup(servers, options)
  require("neodev").setup({});
  local lspconfig = require "lspconfig"
  local icons = require "configs.icons"

  -- nvim-lsp-installer must be set up before nvim-lspconfig
  require("nvim-lsp-installer").setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
    ui = {
      icons = {
        server_installed = icons.server_installed,
        server_pending = icons.server_pending,
        server_uninstalled = icons.server_uninstalled,
      },
    },
  }

  -- Set up LSP servers
  for server_name, _ in pairs(servers) do
    local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})

    if server_name == "rust_analyzer" then
      local extension_path = vim.fn.glob(vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-*/")
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      require("rust-tools").setup {
        dap = {
          server = opts,
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    elseif server_name == "tsserver" then
      require("typescript").setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    else
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
