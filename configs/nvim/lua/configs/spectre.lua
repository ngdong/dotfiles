local M = {}

function M.setup()
  require('spectre').setup({
    mapping = {
      ['send_to_qf'] = {
        map = "<leader>f",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"
      },
    }
  })
end

return M
