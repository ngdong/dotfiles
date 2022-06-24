-- ============================================================================
-- ===                               KEY MAPPINGS                           ===
-- ============================================================================
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ==== Nomarl Mode ====
-- Don't use arrow keys
keymap("n", "<Left>", "::echoe 'Plz use h'<CR>", opts)
keymap("n", "<Right>", "::echoe 'Plz use l'<CR>", opts)
keymap("n", "<Up>", "::echoe 'Plz use k'<CR>", opts)
keymap("n", "<Down>", "::echoe 'Plz use j'<CR>", opts)

-- Quick window switching
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Resize with arrows
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Center search results
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)

-- ==== Visual Mode ====
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', opts)

-- ==== Visual Block Mode ====
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Disabled to show command history
keymap("n", "q:", "<Nop>", opts)