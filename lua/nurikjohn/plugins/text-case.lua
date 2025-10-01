return {
	"johmsalas/text-case.nvim",
	config = function()
		require("textcase").setup({
			default_keymappings_enabled = true,
			prefix = "~",
		})

		require("textcase.extensions.whichkey").register_prefix("n", "~", "Change text case")

		local map = vim.keymap.set
		map(
			"n",
			"~u",
			"<cmd>lua require('textcase').lsp_rename('to_upper_case')<CR>",
			{ desc = "LSP Rename to UPPER_CASE" }
		)
		map(
			"n",
			"~l",
			"<cmd>lua require('textcase').lsp_rename('to_lower_case')<CR>",
			{ desc = "LSP Rename to lower_case" }
		)
		map(
			"n",
			"~s",
			"<cmd>lua require('textcase').lsp_rename('to_snake_case')<CR>",
			{ desc = "LSP Rename to snake_case" }
		)
		map(
			"n",
			"~c",
			"<cmd>lua require('textcase').lsp_rename('to_camel_case')<CR>",
			{ desc = "LSP Rename to camelCase" }
		)
		map(
			"n",
			"~p",
			"<cmd>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
			{ desc = "LSP Rename to PascalCase" }
		)
	end,
}
