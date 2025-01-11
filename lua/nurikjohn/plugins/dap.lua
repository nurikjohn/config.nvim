return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		"theHamsta/nvim-dap-virtual-text",
	},
	keys = function(_, keys)
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			-- Basic debugging keymaps, feel free to change to your liking!
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
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
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
							id = "stacks",
							size = 0.5,
						},
						{
							id = "repl",
							size = 0.25,
						},
					},
					position = "left",
					size = 40,
				},
				{
					elements = {
						{
							id = "scopes",
							size = 1,
						},
					},
					position = "bottom",
					size = 10,
				},
			},
		})
		-- virtual_text.setup({})

		vim.api.nvim_set_hl(0, "DapBreakpointIcon", { fg = "#EB6F92" })
		vim.api.nvim_set_hl(0, "DapStoppedIcon", { fg = "#F6C177" })

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointIcon", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "", texthl = "DapBreakpointIcon", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapStopped", { text = "󰁔", texthl = "DapStoppedIcon", linehl = "", numhl = "" })

		vim.keymap.set("n", "<space>de", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "Debug: evaluate values" })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close
	end,
}
