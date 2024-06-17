return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"nvim-telescope/telescope-dap.nvim",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
			},
		})

		-- Basic debugging keymaps, feel free to change to your liking!
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "»" },
			mappings = {
				-- Use a table to apply multiple mappings
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			layouts = {
				{
					elements = {
						"scopes",
					},
					size = 30,
					position = "left",
				},
				{
					elements = {
						"stacks",
						"breakpoints",
						"watches",
					},
					size = 30,
					position = "right",
				},
				{
					elements = {
						"repl",
					},
					size = 7,
					position = "bottom",
				},
			},
			floating = {
				max_height = nil, -- These can be integers or a float between 0 and 1.
				max_width = nil, -- Floats will be treated as percentage of your screen.
				border = "rounded", -- Border style. Can be "single", "double" or "rounded"
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			controls = {
				enabled = true,
				-- Display controls in this element
				element = "repl",
				icons = {
					pause = "",
					play = "",
					step_into = "",
					step_over = "",
					step_out = "",
					step_back = "",
					run_last = "",
					terminate = "",
				},
			},
			windows = { indent = 1 },
		})

		-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		vim.keymap.set("n", "<leader>dl", dapui.toggle, { desc = "Debug: See last session result." })

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		vim.keymap.set("n", "<leader>dq", function()
			require("dap").close()
			dapui.close()
		end, { desc = "Close Session" })

		vim.keymap.set("n", "<leader>ddr", function()
			require("dap").repl.toggle()
		end, { desc = "REPL" })
		vim.keymap.set("n", "<leader>dds", function()
			require("dapui").float_element("scopes")
		end, { desc = "Scopes" })
		vim.keymap.set("n", "<leader>ddt", function()
			require("dapui").float_element("stacks")
		end, { desc = "Threads" })
		vim.keymap.set("n", "<leader>ddu", function()
			require("dapui").toggle()
		end, { desc = "Toggle Debugger UI" })
		vim.keymap.set("n", "<leader>ddw", function()
			require("dapui").float_element("watches")
		end, { desc = "Watches" })
		vim.keymap.set("n", "<leader>ddx", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Inspect" })

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = "C:\\Users\\chitr\\cpptools-win64\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe",
			options = {
				detached = false,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				externalConsole = true,
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				externalConsole = true,
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp
	end,
}
