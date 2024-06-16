return {
	"petertriho/nvim-scrollbar",
	opts = {
		show_in_active_only = true,
		handle = {
			text = " ",
			hide_if_all_visible = true, -- Hides handle if all lines are visible
		},
		marks = {
			Search = { text = { "-", "=" }, priority = 0 },
			Error = { text = { "-", "=" }, priority = 1 },
			Warn = { text = { "-", "=" }, priority = 2 },
			Info = { text = { "-", "=" }, priority = 3 },
			Hint = { text = { "-", "=" }, priority = 4 },
			Misc = { text = { "-", "=" }, priority = 5 },
		},
		excluded_filetypes = {
			"",
			"prompt",
			"TelescopePrompt",
			"noice",
		},
		autocmd = {
			render = {
				"BufWinEnter",
				"TabEnter",
				"TermEnter",
				"WinEnter",
				"CmdwinLeave",
				"TextChanged",
				"VimResized",
				"WinScrolled",
			},
		},
		handlers = {
			diagnostic = false,
			search = false,
		},
	},
}
