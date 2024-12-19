return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
		"neovim/nvim-lspconfig", -- optional
	},
	opts = {
		document_color = {
			enabled = true,
			kind = "background",
			inline_symbol = "󰝤",
			debounce = 200,
		},
	}, -- your configuration
	config = function()
		require("tailwind-tools").setup({})
	end,
}
