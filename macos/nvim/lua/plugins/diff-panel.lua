-- Trimmed profile for the herdr-diff panel (NVIM_DIFF_PANEL=1).
-- It is a read-only glance at the working tree: no LSP, completion,
-- formatting or linting is ever used there, so don't pay for them.
if vim.env.NVIM_DIFF_PANEL ~= "1" then
	return {}
end

-- Health/startup warnings belong in the editor, not in a glance panel.
vim.notify = function() end
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		vim.notify = function() end
	end,
})

return {
	{ "neovim/nvim-lspconfig", enabled = false },
	{ "saghen/blink.cmp", enabled = false },
	{ "stevearc/conform.nvim", enabled = false },
	{ "mfussenegger/nvim-lint", enabled = false },
	{ "folke/noice.nvim", enabled = false },
	{ "mrcjkb/rustaceanvim", enabled = false },
	{ "Saecki/crates.nvim", enabled = false },
	{ "folke/persistence.nvim", enabled = false },
	{ "b0o/SchemaStore.nvim", enabled = false },
	{ "vuki656/package-info.nvim", enabled = false },

	-- Tab bar buys nothing in a one-buffer panel; the row buys a line of code.
	{ "akinsho/bufferline.nvim", enabled = false },

	-- Never install parsers here: a missing one blocks the panel on a
	-- hit-enter prompt (jsonc's upstream currently 403s). The editor installs.
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = {}
			return opts
		end,
	},

}
