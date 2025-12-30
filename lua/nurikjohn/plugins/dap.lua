return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				opts.ensure_installed = opts.ensure_installed or {}
				table.insert(opts.ensure_installed, "js-debug-adapter")
			end,
		},
	},
	keys = function(_, keys)
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			{ "<leader>ds", dap.continue, desc = "Start/Continue" },
			{ "<leader>dd", dap.disconnect, desc = "Disconnect" },
			{ "<leader>di", dap.step_into, desc = "Step Into" },
			{ "<leader>da", dap.step_over, desc = "Step Over" },
			{ "<leader>do", dap.step_out, desc = "Step Out" },
			{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
			{
				"<leader>dB",
				function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Set Breakpoint",
			},
			{ "<leader>dt", dapui.toggle, desc = "See last session result." },
			unpack(keys),
		}
	end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local virtual_text = require("nvim-dap-virtual-text")

		dapui.setup({
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "breakpoints",
							size = 0.25,
						},
						{
							id = "scopes",
							size = 0.75,
						},
					},
					position = "left",
					size = 40,
				},
				-- {
				-- 	elements = {
				-- 		{
				-- 			id = "stacks",
				-- 			size = 1,
				-- 		},
				-- 	},
				-- 	position = "bottom",
				-- 	size = 10,
				-- },
			},
		})
		virtual_text.setup({})

		vim.api.nvim_set_hl(0, "DapBreakpointIcon", { fg = "#EB6F92" })
		vim.api.nvim_set_hl(0, "DapStoppedIcon", { fg = "#F6C177" })

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointIcon", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DapBreakpointIcon", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapStopped", { text = "󰁔", texthl = "DapStoppedIcon", linehl = "", numhl = "" })

		vim.keymap.set("n", "<space>de", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "Debug: evaluate values" })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		if not dap.adapters["pwa-node"] then
			local js_debug_path = vim.fn.stdpath("data")
				.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"
			require("dap").adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path, "${port}" },
				},
			}
		end
		if not dap.adapters["node"] then
			dap.adapters["node"] = function(cb, config)
				if config.type == "node" then
					config.type = "pwa-node"
				end
				local nativeAdapter = dap.adapters["pwa-node"]
				if type(nativeAdapter) == "function" then
					nativeAdapter(cb, config)
				else
					cb(nativeAdapter)
				end
			end
		end

		local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

		local vscode = require("dap.ext.vscode")
		vscode.type_to_filetypes["node"] = js_filetypes
		vscode.type_to_filetypes["pwa-node"] = js_filetypes

		for _, language in ipairs(js_filetypes) do
			if not dap.configurations[language] then
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug TS file",
						runtimeExecutable = "node",
						runtimeArgs = {
							"--import",
							"tsx",
							"${file}",
						},
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						console = "integratedTerminal",
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug TS (stop on entry)",
						runtimeExecutable = "node",
						runtimeArgs = {
							"--import",
							"tsx",
							"${file}",
						},
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**", "node_modules/**" },
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						console = "integratedTerminal",
						stopOnEntry = true,
					},
					{
						type = "pwa-node",
						request = "launch",
						name = "Debug JS file",
						program = "${file}",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
						console = "integratedTerminal",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach to process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						skipFiles = { "<node_internals>/**" },
					},
				}
			end
		end
	end,
}
