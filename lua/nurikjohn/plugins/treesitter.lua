return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"query",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "ruby" },
				disable = { "markdown", "markdown_inline" },
			},
			indent = { enable = true, disable = { "ruby", "markdown", "markdown_inline" } },
			textobjects = {
				select = {
					enable = false,
				},
			},
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown", "markdown_inline" },
			callback = function()
				vim.treesitter.stop()
			end,
		})
	end,
}
