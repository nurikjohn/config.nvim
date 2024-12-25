return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
						{ find = "%d fewer lines" },
						{ find = "%d more lines" },
					},
				},
				opts = { skip = true },
			},
		},
		presets = {
			long_message_to_split = true,
			inc_rename = false,
			lsp_doc_border = false,
		},
		cmdline = {
			enabled = true,
			view = "cmdline",
			opts = {},

			---@type table<string, CmdlineFormat>
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = { view = "cmdline_input", icon = "󰥻 " },
			},
		},
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify",
	},
}
