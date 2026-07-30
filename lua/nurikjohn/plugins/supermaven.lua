return {
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				enabled = false,
				keymaps = {
					accept_suggestion = "<C-j>",
					clear_suggestion = "<C-x>",
					accept_word = "<C-k>",
				},
			})
		end,
	},
}
