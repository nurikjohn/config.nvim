return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			"giuxtaposition/blink-cmp-copilot",
		},

		version = "v0.*",
		opts = {
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
				-- Blink does not expose its default kind icons so you must copy them all (or set your custom ones) and add Copilot
				kind_icons = {
					Copilot = "",
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
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,

						transform_items = function(_, items)
							local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
							local kind_idx = #CompletionItemKind + 1
							CompletionItemKind[kind_idx] = "Copilot"
							for _, item in ipairs(items) do
								item.kind = kind_idx
							end
							return items
						end,
					},
					markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" },
				},
				default = { "lsp", "path", "snippets", "buffer", "markdown", "copilot" },
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
	{
		"giuxtaposition/blink-cmp-copilot",
	},
}
