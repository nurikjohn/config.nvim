return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		dim = {
			scope = {
				min_size = 5,
				max_size = 20,
				siblings = true,
				cursor = false,
				treesitter = {
					enabled = true,
					blocks = { enabled = true },
				},
			},
		},
	},
	keys = {
		{
			"<leader>ud",
			function()
				local snacks = require("snacks")

				if snacks.dim.enabled then
					snacks.dim.disable()
				else
					snacks.dim.enable()
				end
			end,
			desc = "Toggle Dim",
		},
	},
}
