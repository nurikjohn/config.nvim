return {
	"johmsalas/text-case.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("textcase").setup({
			default_keymappings_enabled = true,
			prefix = "<leader>cc",
		})
		require("telescope").load_extension("textcase")

		require("textcase.extensions.whichkey").register_prefix("n", "<leader>cc", "Change text case")
	end,
	cmd = {
		"Subs",
		"TextCaseOpenTelescope",
		"TextCaseOpenTelescopeQuickChange",
		"TextCaseOpenTelescopeLSPChange",
		"TextCaseStartReplacingCommand",
	},
	lazy = false,
}
