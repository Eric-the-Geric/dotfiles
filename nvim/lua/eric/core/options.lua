local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap
-- found this solution for mapleader: https://www.reddit.com/r/neovim/comments/yccqik/cant_get_remaps_with_space_as_leader_to_work/
keymap("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
--vim.g.maplocalleader = " "
vim.cmd([[
:set number
:set relativenumber
:set clipboard=unnamedplus
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set nohlsearch
:set hidden
:set incsearch
:set scrolloff=8
:set colorcolumn=80
:set signcolumn=yes
:set cmdheight=2
:set nowrap
:set tgc
]])

keymap("n", "<leader>pv", ":Explore<CR>", opts)
