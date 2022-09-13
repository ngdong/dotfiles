-- ============================================================================
-- ===                               PLUGINS                                ===
-- ============================================================================
local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    compile_path = vim.fn.stdpath 'data' .. '/site/pack/loader/start/packer.nvim/plugin/packer.lua',
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  local function plugins(use)
    -- General Plugins
    use { "lewis6991/impatient.nvim" }
    use { "wbthomason/packer.nvim" }
    use { "nvim-lua/plenary.nvim" }
    use { "nvim-lua/popup.nvim" }
    use { "antoinemadec/FixCursorHold.nvim" }

    -- Dev icons
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup {
          default = true
        }
      end
    }

    -- Colorscheme
    use {
      "folke/tokyonight.nvim",
      config = function()
        vim.g.tokyonight_style = "night"
        vim.g.tokyonight_italic_functions = true
        vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
        vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
        vim.cmd [[colorscheme tokyonight]]
      end
    }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("configs.alpha").setup()
      end
    }

    -- Git
    use {
      'TimUntersberger/neogit',
      requires = {
        "nvim-lua/plenary.nvim"
      },
      config = function()
        require("neogit").setup()
      end
    }
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      },
      config = function()
        require("configs.gitsigns").setup()
      end
    }
    use {
      "tpope/vim-fugitive",
      opt = true,
      cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      requires = { "tpope/vim-rhubarb", "idanarye/vim-merginal" },
    }
    use {
      "akinsho/git-conflict.nvim",
      tag = "*",
      config = function()
        require("configs.git-conflict").setup()
      end
    }
    -- Which key
    use {
      "folke/which-key.nvim",
      config = function()
        require("configs.which-key").setup()
      end
    }

    -- Customized vim status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      requires = {
        "kyazdani42/nvim-web-devicons"
      },
      config = function()
        require("configs.lualine").setup()
      end
    }

    -- Treesitter - Syntax highlighting
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("configs.treesitter").setup()
      end,
      requires = {
        { "jose-elias-alvarez/nvim-lsp-ts-utils" },
      }
    }

    -- Float terminals
    use {
      "akinsho/toggleterm.nvim",
      config = function()
        require("configs.toggleterm").setup()
      end
    }

    -- A search panel for neovim.
    use {
      "windwp/nvim-spectre",
      config = function()
        require("configs.spectre").setup()
      end
    }

    -- Buffer line
    use {
      "akinsho/bufferline.nvim",
      config = function()
        vim.opt.termguicolors = true
        require("configs.bufferline").setup()
      end
    }

    use {
      "kazhala/close-buffers.nvim",
      cmd = { "BDelete", "BWipeout" },
    }

    -- Trailing whitespace highlighting & automatic fixing
    use { "bronson/vim-trailing-whitespace" }

    -- Change and add such surroundings in pairs
    use { "tpope/vim-surround" }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("configs.indentblankline").setup()
      end
    }

    -- Comment function
    use {
      "numToStr/Comment.nvim",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring"
      },
      config = function()
        require("configs.comment").setup()
      end
    }

    -- Color highlighter
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup()
      end
    }

    -- File explorer
    use {
      "kyazdani42/nvim-tree.lua",
      config = function()
        require("configs.nvimtree").setup()
      end
    }

    -- Code documentation
    use {
      "danymat/neogen",
      config = function()
        require("configs.neogen").setup()
      end,
      cmd = { "Neogen" },
      module = "neogen"
    }

    use {
      "kkoomen/vim-doge",
      run = ":call doge#install()",
      config = function()
        require("configs.doge").setup()
      end,
      cmd = { "DogeGenerate", "DogeCreateDocStandard" }
    }

    -- Telescope - Fuzzy finding, buffer management
    use {
      "nvim-telescope/telescope.nvim",
      opt = true,
      config = function()
        require("configs.telescope").setup()
      end,
      cmd = { "Telescope" },
      module = { "telescope", "telescope.builtin" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-fzf-native.nvim",
        "telescope-project.nvim",
        "telescope-repo.nvim",
        "telescope-file-browser.nvim",
        "telescope-ui-select.nvim",
        "project.nvim",
        "trouble.nvim",
        "telescope-dap.nvim",
        "telescope-frecency.nvim",
        "nvim-neoclip.lua",
        "telescope-smart-history.nvim",
        "telescope-media-files.nvim",
        "aerial.nvim"
      },
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        "nvim-telescope/telescope-project.nvim",
        "cljoly/telescope-repo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sqlite.lua" },
        -- Project settings
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("configs.project").setup()
          end,
        },
        "nvim-telescope/telescope-dap.nvim",
        {
          "AckslD/nvim-neoclip.lua",
          requires = {
            { "tami5/sqlite.lua", module = "sqlite" }
          },
        },
        {
          "stevearc/aerial.nvim",
          config = function()
            require("aerial").setup()
          end,
          module = { "aerial" },
          cmd = { "AerialToggle" },
        },
        "nvim-telescope/telescope-smart-history.nvim",
        "nvim-telescope/telescope-media-files.nvim",
      }
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = { "BufReadPre" },
      wants = {
        "nvim-lsp-installer",
        "cmp-nvim-lsp",
        "lua-dev.nvim",
        "vim-illuminate",
        "null-ls.nvim",
        "schemastore.nvim",
        "typescript.nvim",
        "nvim-navic",
      },
      config = function()
        require("configs.lsp").setup()
      end,
      requires = {
        -- Manage LSP servers
        "williamboman/nvim-lsp-installer",
        "folke/lua-dev.nvim",
        "RRethy/vim-illuminate",
        -- Formatters and linters
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        -- JSON Schema
        "b0o/schemastore.nvim",
        "jose-elias-alvarez/typescript.nvim",
        {
          "SmiteshP/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
        },
      }
    }

    -- Completions plugins
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("configs.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        -- Show function signature when typing
        "hrsh7th/cmp-nvim-lsp-signature-help",
        -- Snippets
        {
          "L3MON4D3/LuaSnip",
          wants = { "friendly-snippets", "vim-snippets" },
          config = function()
            require("configs.snip").setup()
          end
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
      }
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      wants = "nvim-treesitter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("configs.autopairs").setup()
      end
    }

    -- Support use command Lspsaga with completion or use lua function
    use {
      "tami5/lspsaga.nvim",
      config = function()
        require("lspsaga").setup()
      end
    }

    -- Rust
    use {
      "simrat39/rust-tools.nvim",
      after = "nvim-lspconfig",
      requires = {
        "nvim-lua/plenary.nvim",
        "rust-lang/rust.vim"
      },
      opt = true,
      module = "rust-tools",
      ft = { "rust" },
      config = function()
        require("configs.rust").setup()
      end
    }

    use {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      config = function()
        require("crates").setup {
          null_ls = {
            enabled = true,
            name = "crates.nvim",
          },
        }
      end
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      keys = { [[<leader>d]] },
      module = { "dap" },
      wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
      requires = {
        "alpha2phi/DAPInstall.nvim",
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "nvim-telescope/telescope-dap.nvim",
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
        require("configs.dap").setup()
      end
    }

    -- Utils
    -- Rename
    use {
      "filipdutescu/renamer.nvim",
      module = { "renamer" },
      config = function()
        require("renamer").setup {}
      end
    }

    -- Trouble
    use {
      "folke/trouble.nvim",
      wants = "nvim-web-devicons",
      cmd = { "TroubleToggle", "Trouble" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end
    }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      module = { "refactoring", "telescope" },
      keys = { [[<leader>r]] },
      wants = { "telescope.nvim" },
      config = function()
        require("configs.refactoring").setup()
      end
    }

    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use { "nathom/filetype.nvim" }

    -- Testing
    use { "diepm/vim-rest-console", ft = { "rest" } }

    if packer_bootstrap then
      print "Setting up Neovim. Restart required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()

  -- Performance
  pcall(require, "impatient")

  require("packer").init(conf)
  require("packer").startup(plugins)
end

return M
