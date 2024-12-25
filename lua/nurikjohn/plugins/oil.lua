return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	dependencies = {
		{
			"echasnovski/mini.icons",
			opts = {
				file = {
					[".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
					[".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
					[".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
					[".yarnrc.yml"] = { glyph = "", hl = "MiniIconsBlue" },
					["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
					["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
					["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
					["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
					["yarn.lock"] = { glyph = "", hl = "MiniIconsBlue" },
				},
			},
		},
	},
	config = function()
		CustomOilBar = function()
			local path = vim.fn.expand("%")
			path = path:gsub("oil://", "")

			return "  " .. vim.fn.fnamemodify(path, ":.")
		end

		require("oil").setup({
			columns = { "icon" },
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = {
					"actions.select",
					opts = { vertical = true },
					desc = "Open the entry in a vertical split",
				},
				["<C-h>"] = {
					"actions.select",
					opts = { horizontal = true },
					desc = "Open the entry in a horizontal split",
				},
				["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory" },
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
			win_options = {
				winbar = "%{v:lua.CustomOilBar()}",
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}
