local M = {}

function M.setup()
  local tree_cb = require("nvim-tree.config").nvim_tree_callback

  require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    respect_buf_cwd = true,
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    system_open = {
      cmd = nil,
      args = {},
    },
    filters = {
      dotfiles = false,
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      hide_root_folder = false,
      side = "left",
      mappings = {
        custom_only = false,
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "v", cb = tree_cb "vsplit" },
        },
      },
      number = false,
      relativenumber = false,
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
    actions = {
      open_file = {
        quit_on_open = true,
        window_picker = {
          enable = true
        }
      },
    },
    renderer = {
      root_folder_modifier = ":t",
      icons = {
        show = {
          folder = true,
          file = true,
          folder_arrow = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
          },
          folder = {
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
        }
      },
      highlight_git = false
    }
  })
end

return M
