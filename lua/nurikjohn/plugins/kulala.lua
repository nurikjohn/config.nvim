return {
	"mistweaverco/kulala.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	opts = {
		contenttypes = {
			["application/xml"] = {
				ft = "xml",
				formatter = { "prettier", "." },
				pathresolver = {},
			},
			["text/html"] = {
				ft = "html",
				formatter = { "prettier", "." },
				pathresolver = {},
			},
		},
	},
	config = function()
		local kulala = require("kulala")

		vim.keymap.set(
			"n",
			"<leader>kq",
			kulala.scratchpad,
			{ silent = true, noremap = true, desc = "Open scratchpad" }
		)

		kulala.setup()
	end,
}
