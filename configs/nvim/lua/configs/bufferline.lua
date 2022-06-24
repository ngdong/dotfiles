local M = {}

function M.setup()
  require("bufferline").setup {
    options = {
      numbers = "buffer_id",
      show_buffer_close_icons = false,
      show_close_icon = false,
    }
  }
end

return M

