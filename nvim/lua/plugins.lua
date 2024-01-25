-- ??
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
	{
		"rebelot/kanagawa.nvim",
		config = function()
		require('kanagawa').setup({
			compile = false,             -- enable compiling the colorscheme
			undercurl = true,            -- enable undercurls
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true},
			statementStyle = { bold = true },
			typeStyle = {},
			transparent = true,         -- do not set background color
			dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
			terminalColors = true,       -- define vim.g.terminal_color_{0,17}
			colors = {                   -- add/modify theme and palette colors
				palette = {},
				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
			},
			overrides = function(colors) -- add/modify highlights
				return {}
			end,
			theme = "wave",              -- Load "wave" theme when 'background' option is not set
			background = {               -- map the value of 'background' option to a theme
				dark = "wave",           -- try "dragon" !
				light = "lotus"
			},
		})
			vim.cmd.colorscheme("kanagawa-wave")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "lua", "vim", "python", "rust", "javascript", "query", "vimdoc", "python", "r", "rust", "markdown", "regex", "bash"  },
				auto_install = true,
				highlight = {
					enable = true
					},
			})
		end,
	},
})
