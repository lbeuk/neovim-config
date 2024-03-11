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
	-- LSP support
	"neovim/nvim-lspconfig",
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {}
	},
	-- Allows focusing on current code tree
	{
		"folke/twilight.nvim",
		opts = {},
	},
	-- File tree support
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
	-- Icons in file tree, requires a nerd font
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
	},
	-- Autocompletion support
	{
		"ms-jpq/coq_nvim",
		lazy = false,
	},
	{
		"ms-jpq/coq.artifacts",
		branch = "artifacts",
		lazy = false,
	},
	{
		"ms-jpq/coq.thirdparty",
		branch = "3p",
		lazy = false,
	},
	-- Auto close support
	{
		"m4xshen/autoclose.nvim",
		lazy = false,
	},
	-- TODO comment support
	{
		"folke/todo-comments.nvim",
		lazy=false,
		dependencies = {"nvim-lua/plenary.nvim"}
	}
})

require("todo-comments").setup()

------------------
-- Auto closing --
------------------

require("autoclose").setup({
	keys = {
		["("] = { escape = false, close = true, pair = "()" },
	      	["["] = { escape = false, close = true, pair = "[]" },
	      	["{"] = { escape = false, close = true, pair = "{}" },

	      	[">"] = { escape = true, close = false, pair = "<>" },
	      	[")"] = { escape = true, close = false, pair = "()" },
	      	["]"] = { escape = true, close = false, pair = "[]" },
	      	["}"] = { escape = true, close = false, pair = "{}" },

	      	['"'] = { escape = true, close = true, pair = '""' },
	      	["'"] = { escape = true, close = true, pair = "''" },
	      	["`"] = { escape = true, close = true, pair = "``" }
	}
})

-----------------
-- LSP support --
-----------------

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

lspconfig.ccls.setup({
	init_options = {
		cache = {
			directory = ".ccls-cache";
		};
	}
})
---------------------
-- Vim Preferences --
---------------------

vim.wo.number = true
vim.b.expandtab = true
vim.cmd[[colorscheme tokyonight]]

---------------------
-- Vim Keybindings --
---------------------

vim.keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<CR>") -- Ctrl+b :: Toggles/selects filesystem viewer
