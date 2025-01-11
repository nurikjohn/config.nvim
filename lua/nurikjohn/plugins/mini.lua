local get_filesize = function()
	local size = vim.fn.getfsize(vim.fn.getreg("%"))
	if size < 1024 then
		return string.format("%dB", size)
	elseif size < 1048576 then
		return string.format("%.2fKiB", size / 1024)
	else
		return string.format("%.2fMiB", size / 1048576)
	end
end

local get_file_info = function(args)
	local icons = require("mini.icons")

	local filetype = vim.bo.filetype

	if filetype == "" then
		return ""
	end

	if icons.get ~= nil then
		filetype = icons.get("filetype", filetype) .. " " .. filetype
	end

	if MiniStatusline.is_truncated(args.trunc_width) or vim.bo.buftype ~= "" then
		return filetype
	end

	local size = get_filesize()

	return string.format("%s %s", filetype, size)
end

local get_recording_status = function()
	local recording = vim.fn.reg_recording()

	if recording ~= "" then
		return "recording " .. recording
	end

	return ""
end

local active_statusline = function()
	local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
	local git = MiniStatusline.section_git({ trunc_width = 40 })
	local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
	local fileinfo = get_file_info({ trunc_width = 120 })
	local location = MiniStatusline.section_location({ trunc_width = 75 })
	local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
	local filename = "%t %m%r"
	local macro_state = get_recording_status()

	return MiniStatusline.combine_groups({
		{ hl = mode_hl, strings = { mode } },
		{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
		"%<", -- Mark general truncate point
		{ hl = "MiniStatuslineFilename", strings = { filename } },
		"%=", -- End left alignment
		{ hl = "MiniStatuslineFilename", strings = { macro_state } },
		{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
		{ hl = mode_hl, strings = { search, location } },
	})
end

return {
	"echasnovski/mini.nvim",
	config = function()
		require("mini.ai").setup({
			n_lines = 500,
		})

		require("mini.surround").setup({ n_lines = 500 })

		-- local sessions = require("mini.sessions")
		-- sessions.setup({
		-- 	autoread = true,
		-- 	autowrite = true,
		-- })

		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font, content = { active = active_statusline } })

		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		require("mini.icons").setup()
	end,
}
