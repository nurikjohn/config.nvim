return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		dependencies = { "rafamadriz/friendly-snippets" },

		config = function()
			local ls = require("luasnip")
			ls.filetype_extend("javascript", {
				"jsdoc",
				"typescript",
				"typescriptreact",
				"javascriptreact",
				"next",
				"next-ts",
				"react",
				"react-ts",
				"react-native",
				"react-native-ts",
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
