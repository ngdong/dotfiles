local M = {}

function M.setup()
  local dashboard = require("alpha.themes.dashboard")
  dashboard.section.header = {
    type = "text",
    val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    },
    opts = {
      position = "center",
      hl = "AlphaHeader",
    },
  }

  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }


  require("alpha").setup(dashboard.opts)

  -- Disable folding on alpha buffer
  vim.cmd [[
        augroup _alpha
            autocmd!
            autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            autocmd FileType alpha setlocal nofoldenable
        augroup end
    ]]
end

return M
