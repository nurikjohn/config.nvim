return {
	"samir-roy/code-bridge.nvim",
	config = function()
		require("code-bridge").setup({
			tmux = {
				target_mode = "current_window", -- 'window_name', 'current_window', 'find_process'
				process_name = "node", -- used when target_mode = 'current_window' or 'find_process'
				switch_to_target = true, -- whether to switch to target after sending
				find_node_process = true, -- whether to look for a node.js process
			},
		})

		vim.keymap.set("n", "<leader>p", ":CodeBridgeTmux<CR>", { desc = "Send file to claude" })
		vim.keymap.set("v", "<leader>p", ":CodeBridgeTmux<CR>", { desc = "Send selection to claude" })
	end,
}
