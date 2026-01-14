return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},

		version = "v0.*",
		opts = {
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				kind_icons = {
					Text = "󰉿",
					Method = "󰊕",
					Function = "󰊕",
					Constructor = "󰒓",

					Field = "󰜢",
					Variable = "󰆦",
					Property = "󰖷",

					Class = "󱡠",
					Interface = "󱡠",
					Struct = "󱡠",
					Module = "󰅩",

					Unit = "󰪚",
					Value = "󰦨",
					Enum = "󰦨",
					EnumMember = "󰦨",

					Keyword = "󰻾",
					Constant = "󰏿",

					Snippet = "󱄽",
					Color = "󰏘",
					File = "󰈔",
					Reference = "󰬲",
					Folder = "󰉋",
					Event = "󱐋",
					Operator = "󰪚",
					TypeParameter = "󰬛",
				},
			},

			signature = { enabled = true },

			keymap = {
				preset = "default",
				["<C-a>"] = { "select_and_accept" },
			},

			sources = {
				providers = {
					markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" },
				},
				default = { "lsp", "path", "snippets", "buffer", "markdown" },
			},
			completion = {
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 3, "label_description" } },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 20,
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
