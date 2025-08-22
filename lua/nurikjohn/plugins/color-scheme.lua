local current_theme_path = vim.fn.expand("~/.config/themes/current-theme/nvim.lua")

if vim.fn.filereadable(current_theme_path) == 1 then
	return dofile(current_theme_path)
else
	-- Fallback to default theme
	return require("nurikjohn.themes.default-theme")
end
