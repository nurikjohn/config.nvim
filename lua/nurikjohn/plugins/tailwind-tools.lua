return {
	"luckasRanarison/tailwind-tools.nvim",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- optional
	},
	opts = {
		document_color = {
			enabled = true,
			kind = "background",
			inline_symbol = "󰝤",
			debounce = 200,
		},
	},
}
