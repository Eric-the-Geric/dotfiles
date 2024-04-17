-- found this solution for mapleader: https://www.reddit.com/r/neovim/comments/yccqik/cant_get_remaps_with_space_as_leader_to_work/
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
keymap("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
--vim.g.have_nerd_font = true
vim.g.have_nerd_font = true
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
-- keymaps:
keymap("n", "<leader>pv", ":Explore<CR>", opts)
keymap("v", "<leader>w", ':Wrapvis<CR>', opts)
keymap("n", "<leader>w",":Wrap<CR>", opts)

vim.api.nvim_create_user_command('Wrap',
    function()
        -- Mapping table for opening and closing characters
        local brackets = {
            ['('] = ')',
            ['['] = ']',
            ['{'] = '}',
            ['<'] = '/>', -- Handling XML/HTML-like tags
            ['"'] = '"',    -- Double quotes
            ["'"] = "'",    -- Single quotes
            ['`'] = '`',    -- Backticks
            ['«'] = '»'     -- Guillemets
        }
        local opening = vim.fn.input('Character: ')
        local closing = brackets[opening] or opening
        -- Correctly formatted command using nvim_replace_termcodes to handle <C-o> and other special keys
        local formatted_cmd = string.format(":norm! bi%s<C-o>e<C-o>a%s",
            opening,
            closing)
        -- Execute the formatted command using termcodes replaced
        vim.api.nvim_exec(vim.api.nvim_replace_termcodes(formatted_cmd, true, true, true), false)
    end,
    {range = '%'}  -- This sets the command to allow any range specification
)

vim.api.nvim_create_user_command('Wrapvis',
    function(options)
        local brackets = {
            ['('] = ')',
            ['['] = ']',
            ['{'] = '}',
            ['<'] = '/>', -- Handling XML/HTML-like tags
            ['"'] = '"',    -- Double quotes
            ["'"] = "'",    -- Single quotes
            ['`'] = '`',    -- Backticks
            ['«'] = '»'     -- Guillemets
        }

        local opening = vim.fn.input('Character: ')
        local closing = brackets[opening] or opening

        -- Decide the appropriate command based on whether a range was used
        local formatted_cmd
		if options.range then
		formatted_cmd = string.format(":'<,'>norm I%s<C-o>$%s,",
			opening,
			closing)
		end
		vim.api.nvim_exec(vim.api.nvim_replace_termcodes(formatted_cmd, true, true, true), false)
    end,
    {range = '%'}  -- Allows the command to handle ranges, should apply in visual mode
)
