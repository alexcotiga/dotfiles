-- lua/plugins/gruber-darker.lua
-- Gruber Darker theme. This is a dark-only theme, so there is no light/dark
-- auto-switching (the previous auto-dark-mode.nvim setup was removed with it).
return {
	"blazkowolf/gruber-darker.nvim",
	name = "gruber-darker",
	priority = 1000, -- load the colorscheme before other plugins
	config = function()
		require("gruber-darker").setup({})
		vim.cmd("colorscheme gruber-darker")
	end,
}
