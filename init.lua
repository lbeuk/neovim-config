------------------------
-- Plugin Installation --
-------------------------

-- Bootstrap lazy.nvim (https://github.com/folke/lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim
require("lazy").setup({
	"neovim/nvim-lspconfig",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	},
	{
		"folke/twilight.nvim",
		opts = {},
	},
	{
    		"nvim-neo-tree/neo-tree.nvim",
    		branch = "v3.x",
    		dependencies = {
			"nvim-lua/plenary.nvim",
		      	"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		      	"MunifTanjim/nui.nvim",
		      	-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
	}
})

-------------------
-- Rust-analyzer --
-------------------

local lspconfig = require'lspconfig'

local on_attach = function(client)
	require'completion'.on_attach(client)
end

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		}
	}
})

---------------------
-- Vim Preferences --
---------------------

vim.wo.number = true
vim.b.expandtab = true
vim.cmd[[colorscheme tokyonight]]
