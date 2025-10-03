---@diagnostic disable: undefined-global
vim.lsp.inlay_hint.enable(true)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		vim.keymap.set(
			"n",
			"gd",
			require("telescope.builtin").lsp_definitions,
			{ buffer = event.buf, desc = "Go to definition" }
		)
		vim.keymap.set(
			"n",
			"gr",
			require("telescope.builtin").lsp_references,
			{ buffer = event.buf, desc = "Go to references" }
		)
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
		vim.keymap.set({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Actions" })

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.server_capabilities.documentHighlightProvider then
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	end,
})

-- Helper function to get LSP names from lsp/ directory
local function get_lsp_names()
	local filenames = vim.fn.glob(vim.fn.stdpath("config") .. "/lsp/*.lua")
	local filename_table = vim.split(filenames, "\n")
	local result = {}
	for _, path in ipairs(filename_table) do
		local name = vim.fn.fnamemodify(path, ":t:r")
		if name ~= "" then
			table.insert(result, name)
		end
	end
	return result
end

-- Configure diagnostics
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = "󰗖 ",
			[vim.diagnostic.severity.HINT] = "󰘥 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
		},
	},
})

-- Configure LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
capabilities = vim.tbl_deep_extend("force", capabilities, {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		},
	},
})

-- Set default config for all LSP servers
vim.lsp.config("*", {
	root_markers = { ".git" },
	capabilities = capabilities,
})

-- Load configs from lsp/ directory and configure each server
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local lsps = get_lsp_names()

for _, lsp_name in ipairs(lsps) do
	local config_file = lsp_dir .. "/" .. lsp_name .. ".lua"
	local ok, config = pcall(dofile, config_file)
	if ok and config then
		vim.lsp.config[lsp_name] = config
	end
end

-- Enable all LSP servers
vim.lsp.enable(lsps)

-- Add LspInfo command
vim.api.nvim_create_user_command("LspInfo", function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		print("No LSP clients attached to current buffer")
		return
	end
	for _, client in ipairs(clients) do
		print(string.format("• %s (id: %d)", client.name, client.id))
	end
end, {})
