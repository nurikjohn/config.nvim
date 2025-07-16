return {
	-- {
	-- 	"nurikjohn/anysphere",
	-- 	dir = "/Users/nurik/Documents/code/config/anysphere",
	-- 	name = "anysphere",
	-- 	config = function()
	-- 		-- require("anysphere").setup({})
	-- 		-- require("anysphere").load()
	-- 	end,
	-- },
	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	name = "onedark",
	-- 	config = function()
	-- 		-- require("onedark").setup({
	-- 		-- style = "warmer",
	-- 		-- })
	-- 		-- require("onedark").load()
	-- 	end,
	-- },
	-- {
	-- 	"rose-pine/neovim",
	-- 	name = "rose-pine",
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- },
	-- {
	-- 	"kdheepak/monochrome.nvim",
	-- 	name = "monochrome",
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme monochrome")
	-- 	end,
	-- },
	-- {
	-- 	"projekt0n/github-nvim-theme",
	-- 	name = "github-theme",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme github_dark")
	-- 	end,
	-- },
	{
		"kepano/flexoki-neovim",
		name = "flexoki",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme flexoki-dark")
		end,
	},
}
