return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					".git",
				},
				-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				prompt_prefix = "  ",
				selection_caret = "  ",
				entry_prefix = "   ",
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search resume" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search word" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
		vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search existing buffers" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search select telescope" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })

		vim.keymap.set("n", "<leader>se", function()
			builtin.find_files({
				prompt_title = "Search .env Files",
				hidden = true,
				find_command = { "find", ".", "-maxdepth", "1", "-type", "f", "-name", ".env*" },
			})
		end, { desc = "Search .env files" })

		vim.keymap.set("n", "<leader><leader>", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Search in current buffer" })

		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live grep in open files",
			})
		end, { desc = "Search in open files" })

		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Search neovim files" })
	end,
}
