return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }),
}
