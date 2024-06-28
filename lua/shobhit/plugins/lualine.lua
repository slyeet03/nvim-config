return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local nvimbattery = {
			function()
				return require("battery").get_status_line()
			end,
			-- color = { fg = #836FFF, bg = #211951 },
		}

		-- configure lualine with modified theme
		lualine.setup({
			sections = {
				lualine_a = nvimbattery,
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
						function()
							local enabled = require("pigeon.config").options.battery.enabled
							local battery = require("pigeon.battery").battery()

							if enabled then
								return battery
							else
								return ""
							end
						end,
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
