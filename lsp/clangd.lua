return {
	cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" },
	root_markers = { "compile_commands.json", ".clangd", ".git" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
}
