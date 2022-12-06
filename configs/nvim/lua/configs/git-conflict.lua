local M = {}

vim.api.nvim_set_hl(0, "ConflictMarkerOurs", { bg = "#2e5049" })
vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", { bg = "#344f69" })
vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", { bg = "#754a81" })

function M.setup()
  require("git-conflict").setup({
    default_mappings = false,
    disable_diagnostics = false,
    highlights = {
      current = "ConflictMarkerOurs",
      incoming = "ConflictMarkerTheirs",
      ancestor = "ConflictMarkerCommonAncestorsHunk"
    }
  })
end

return M
