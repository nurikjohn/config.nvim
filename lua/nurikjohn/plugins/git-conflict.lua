return {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = function()
		require("git-conflict").setup({
			default_mappings = false,
		})

		vim.keymap.set("n", "<leader>co", "<cmd>GitConflictChooseOurs<cr>", { desc = "Choose Ours" })
		vim.keymap.set("n", "<leader>ct", "<cmd>GitConflictChooseTheirs<cr>", { desc = "Choose Theirs" })
		vim.keymap.set("n", "<leader>ca", "<cmd>GitConflictAccept<cr>", { desc = "Accept" })
		vim.keymap.set("n", "<leader>cb", "<cmd>GitConflictChooseBoth<cr>", { desc = "Choose Both" })
		vim.keymap.set("n", "<leader>c0", "<cmd>GitConflictChooseNone<cr>", { desc = "Choose None" })
		vim.keymap.set("n", "<leader>cn", "<cmd>GitConflictNext<cr>", { desc = "Next" })
		vim.keymap.set("n", "<leader>cp", "<cmd>GitConflictPrev<cr>", { desc = "Prev" })
		vim.keymap.set("n", "<leader>cq", "<cmd>GitConflictListQF<cr>", { desc = "List" })
	end,
}
