return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"stylua",
				"gopls",
				"lua-language-server",
				"pyright",
				"tailwindcss-language-server",
				"typescript-language-server",
			},
		},
	},
}
