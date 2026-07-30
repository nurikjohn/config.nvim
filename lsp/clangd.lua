return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--query-driver=/Users/nurik/.platformio/packages/toolchain-riscv32-esp/bin/riscv32-esp-elf-g++",
	},
	root_markers = { "compile_commands.json", ".clangd", ".git" },
	filetypes = { "c", "cpp", "objc", "objcpp" },
}
