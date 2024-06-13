return {
	"mrcjkb/rustaceanvim",
	version = "^4", -- Recommended
	lazy = false, -- This plugin is already lazy

	config = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.keymap.set("n", "<leader>qq", function()
			vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
		end, { silent = true, buffer = bufnr })
		vim.keymap.set("n", "<leader>qh", function()
			vim.cmd.RustLsp({ "hover", "actions" })
		end, { silent = true, buffer = bufnr })
		vim.keymap.set("n", "<leader>qf", function()
			vim.lsp.buf.format({ timeout_ms = 10000 })
		end, { silent = true, buffer = bufnr })
	end,
}
