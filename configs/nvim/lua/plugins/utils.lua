return {
	-- Performance
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- Library used by other plugins
	{ "nvim-lua/plenary.nvim", lazy = true },

	-- Makes some plugins dot-repeatable like leap
	{ "tpope/vim-repeat", event = "VeryLazy" },
}
