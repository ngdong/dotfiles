local indent = 2
local api = vim.api
local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

cmd [[filetype plugin indent on]]
cmd [[syntax enable]]

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true -- Set highlight on search
opt.number = true -- Make line numbers default
opt.relativenumber = true -- Make relative number default
opt.mouse = "v" -- Enable mouse mode
opt.breakindent = true -- Enable break indent
opt.undofile = true -- Save undo history
opt.ignorecase = true -- Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 -- Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamed,unnamedplus" -- Access system clipboard
opt.backup = false -- Creates a backup file
opt.cmdheight = 1 -- More space in the neovim command line for displaying messages
opt.completeopt = { "menuone", "noselect" } -- Mostly just for cmp
opt.fileencoding = "utf-8" -- The encoding written to a file
opt.pumheight = 10 -- Pop up menu height
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.showtabline = indent -- Always show tabs
opt.smartindent = true -- Make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- Force all vertical splits to go to the right of current window
opt.swapfile = false -- Creates a swapfile
opt.timeoutlen = 100 -- Time to wait for a mapped sequence to complete (in milliseconds)
opt.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
opt.expandtab = true -- Convert tabs to spaces
opt.shiftwidth = indent -- The number of spaces inserted for each indentation
opt.tabstop = indent -- Insert 2 spaces for a tab
opt.cursorline = true -- Highlight the current line
opt.numberwidth = indent -- Set number column width to 2 {default 4}
opt.wrap = false -- Display lines as one long line
opt.autoindent = true
opt.hidden = true
opt.history = 100
opt.inccommand = "split"
opt.lazyredraw = false
opt.number = true
opt.pumblend = 17
opt.scrolloff = 999
opt.sessionoptions = "blank,buffers,curdir,folds,help,options,tabpages,winsize,resize,winpos,terminal"
opt.shiftround = true
opt.sidescrolloff = 999
opt.smarttab = true
opt.softtabstop = indent
opt.synmaxcol = 240
opt.path:append "**"
opt.guifont = "Fira Code Regular:h12" -- The font used in graphical neovim applications
-- opt.formatoptions:append "cqnj"
-- opt.formatoptions:remove "ator2"

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

opt.formatoptions = opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    - "r" -- Don't insert comment after <Enter>
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore

-- g.virtualedit = "all"
g.vim_markdown_fenced_languages = { "html", "javascript", "typescript", "css", "python", "lua", "vim" }
