return {
	"tpope/vim-fugitive",
	cmd = { "Git", "Gedit", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite" },
	keys = {
		{ "<leader>go", "<cmd>Gedit HEAD:%<cr>", desc = "Open HEAD version" },
		{ "<leader>gd", "<cmd>Gvdiffsplit HEAD:%<cr>", desc = "Diff vs HEAD" },
	},
}
