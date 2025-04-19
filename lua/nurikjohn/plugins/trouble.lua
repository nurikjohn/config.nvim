return {
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})

			vim.keymap.set("n", "<leader>tt", function()
				require("trouble").toggle({ mode = "diagnostics" })
			end, { desc = "Open diagnostics" })

			vim.keymap.set("n", "[t", function()
				require("trouble").next({ skip_groups = true, jump = true, mode = "diagnostics" })
			end, { desc = "Go to next issue" })

			vim.keymap.set("n", "]t", function()
				require("trouble").previous({ skip_groups = true, jump = true, mode = "diagnostics" })
			end, { desc = "Go to previous issue" })
		end,
	},
}
