return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
	config = function()
		vim.keymap.set("n", "<leader>r.", function()
			vim.cmd(":Rest run")
		end, { silent = true, noremap = true, desc = "Run current request" })

		vim.keymap.set("n", "<leader>rc", function()
			vim.cmd(":Rest cookies")
		end, { silent = true, noremap = true, desc = "Edit cookies" })

		vim.keymap.set("n", "<leader>rn", function()
			local name = vim.fn.input("Request name: ")

			vim.cmd(":Rest run " .. name)
		end, { silent = true, noremap = true, desc = "Run request" })
	end,
}
