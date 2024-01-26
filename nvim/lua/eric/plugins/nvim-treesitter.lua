return {
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
}
