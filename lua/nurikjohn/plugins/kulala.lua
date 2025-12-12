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
				formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "-" },
				pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
			},
			["text/html"] = {
				ft = "html",
				formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "--html", "-" },
				pathresolver = nil,
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
