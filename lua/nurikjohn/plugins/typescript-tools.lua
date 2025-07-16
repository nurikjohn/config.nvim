return {
	"pmizio/typescript-tools.nvim",
	event = { "BufReadPre *.ts,*.tsx,*.js,*.jsx", "BufNewFile *.ts,*.tsx,*.js,*.jsx" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {
		settings = {
			tsserver_file_preferences = {},
			expose_as_code_action = {
				"fix_all",
				"add_missing_imports",
				"remove_unused",
				"remove_unused_imports",
				"organize_imports",
			},
			publish_diagnostic_on = "insert_leave",
		},
	},
}
