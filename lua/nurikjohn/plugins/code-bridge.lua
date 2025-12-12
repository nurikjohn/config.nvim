return {
	-- "nurikjohn/code-bridge.nvim",
	dir = "~/Documents/code/personal/code-bridge.nvim",
	name = "code-bridge",
	config = function()
		require("code-bridge").setup({
			tmux = {
				target_mode = "current_window", -- 'window_name', 'current_window', 'find_process'
				process_name = { "node", "opencode" }, -- used when target_mode = 'current_window' or 'find_process'
				switch_to_target = true, -- whether to switch to target after sending
				find_node_process = true, -- whether to look for a node.js process
			},
			use_telescope = true,
		})

		vim.keymap.set("v", "<leader>pp", ":CodeBridgeTmux<CR>", { desc = "Send selection to claude" })
		vim.keymap.set("n", "<leader>pp", ":CodeBridgeTmux<CR>", { desc = "Send file to claude" })
		vim.keymap.set("n", "<leader>pd", ":CodeBridgeTmuxDiagnostics<CR>", { desc = "Send diagnostics to claude" })
		vim.keymap.set(
			"n",
			"<leader>pD",
			":CodeBridgeTmuxDiagnosticsAll<CR>",
			{ desc = "Send all diagnostics to claude" }
		)
		vim.keymap.set("n", "<leader>pe", ":CodeBridgeTmuxDiagnosticsErrors<CR>", { desc = "Send errors to claude" })
		vim.keymap.set(
			"n",
			"<leader>pE",
			":CodeBridgeTmuxDiagnosticsErrorsAll<CR>",
			{ desc = "Send all errors to claude" }
		)
	end,
}
