return {
	"laytan/cloak.nvim",
	config = function(event)
		require("cloak").setup({
			enabled = true,
			patterns = {
				{
					file_pattern = ".env*",
					cloak_pattern = {
						{ "(= ).+", replace = "%1" },
					},
					replace = nil,
				},
			},
			replace = "[outer] %1",
		})

		vim.keymap.set("n", "g.", require("cloak").toggle, { buffer = event.buf, desc = "Toggle cloak" })
	end,
}
