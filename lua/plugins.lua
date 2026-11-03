local gh = function(url)
	return "https://github.com/" .. url
end

vim.pack.add {
	-- colorschemes --
	gh "mofiqul/vscode.nvim",
	-- gh("morhetz/gruvbox"),
	gh "projekt0n/github-nvim-theme",
	gh "watcol/onelight.vim",
	gh "sainnhe/everforest",
	gh "josebalius/vim-light-chromeclipse",
	-- gh("scottmckendry/cyberdream.nvim"),

	-- language support --
	gh "stevearc/conform.nvim", -- formatter
	gh "neovim/nvim-lspconfig", -- lsp configurations
	gh "nvim-treesitter/nvim-treesitter", -- ts-grammer manager
	gh "nvim-treesitter/nvim-treesitter-context", -- sticky header

	-- other --
	gh "junegunn/fzf.vim", -- pretty file-picker
	gh "Pocco81/auto-save.nvim", -- autosave file after change
	{ src = gh "nvim-neo-tree/neo-tree.nvim", version = "v3.x" }, -- filetree
	gh "lewis6991/gitsigns.nvim", -- git status
	gh "akinsho/bufferline.nvim", -- fancy "tabbar"
	gh "petertriho/nvim-scrollbar", -- visual scrollbar
	gh "rachartier/tiny-code-action.nvim", -- visualize code actions
	gh "numToStr/Comment.nvim", -- comment and uncomment lines
	gh "folke/todo-comments.nvim", -- highlight TODO's
	gh "timantipov/md-table-tidy.nvim", -- format markdown tables
	gh "hedyhli/outline.nvim", -- show buffer outlines (functions, headers)
	gh "lukas-reineke/indent-blankline.nvim", -- indentation visualizer
	gh "sakhnik/nvim-gdb", -- gdb debugger
	gh "attilarepka/header.nvim", -- add headers
	gh "Groveer/plantuml.nvim", -- plantuml preview
	gh "mfussenegger/nvim-jdtls", -- must-have for Java Folks (I guess?)
	-- gh "f-person/auto-dark-mode.nvim", -- auto dark/light theme

	-- dependencies --
	gh "nvim-lua/plenary.nvim", -- utilties; ->neo-tree, tiny-code-action, todo-comments
	gh "MunifTanjim/nui.nvim", -- ui toolkit; ->neo-tree
	gh "nvim-tree/nvim-web-devicons", -- file icons; ->neo-tree
	gh "nvim-telescope/telescope.nvim", -- popups ->tiny-code-action
	gh "3rd/image.nvim", -- image previewer; ->plantuml-preview
}

require("conform").setup {
	formatters = {
		prettier = {
			prepend_args = { "--plugin=prettier-plugin-svelte" },
		},
		mdfmt = {
			command = "mdfmt",
		},
		autopep8 = {
			append_args = { "--max-line-length", "120" },
		},
		xmlstarlet = {
			command = "xml",
		},
		stylua = {
			append_args = { "--call-parentheses", "None" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofmt" },
		c = { "clang-format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		svelte = { "prettier" },
		json = { "jq" },
		markdown = { "mdfmt" },
		python = { "autopep8" },
		xml = { "xmlstarlet" },
		sql = { "sqruff" },
		latex = { "tex-fmt" },
	},
}

require("auto-save").setup {
	trigger_events = { "InsertLeave" },
	debounce_delay = 500,
}

require("neo-tree").setup {
	window = {
		position = "right",
	},
	filesystem = {
		filtered_items = {
			visible = true,
			group_empty_dirs = true,
		},
		never_show = {
			"target",
		},
	},
}

require("bufferline").setup {
	--diagnostics = "nvim_lsp",
}

require("scrollbar").setup {}

require("Comment").setup {}

require("todo-comments").setup {}

require("md-table-tidy").setup {}

require("gitsigns").setup {}

require("outline").setup {}

require("ibl").setup {}

require("header").setup {}

require("plantuml").setup {}

require("nvim-treesitter").setup {}
require("nvim-treesitter").install {
	"go",
	"comment",
	"markdown-inline",
	"markdown",
	"sql",
	"lua",
	"javascript",
	"css",
	"html",
	"svelte",
	"json",
	"typescript",
}

require("image").setup()

-- require("auto-dark-mode").setup()

require("treesitter-context").setup()

--require("plantuml-preview").setup {}

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_autocmd("bufwritepre", {
	pattern = "*",
	callback = function(args)
		if not vim.g.noautoformat then
			require("conform").format {
				bufnr = args.buf,
				lsp_format = "fallback",
			}
		end
	end,
})

vim.api.nvim_create_user_command("FormatToggle", function()
	vim.g.noautoformat = not vim.g.noautoformat
	print("Autoformat: " .. tostring(not vim.g.noautoformat))
end, {})
