--
--  My basic settings
--
vim.opt.encoding='UTF-8'
vim.opt.cursorline=true
vim.opt.laststatus=2
vim.opt.cmdheight=2
vim.opt.showmatch=true
vim.opt.autoindent=true
vim.opt.smartindent=true
vim.opt.list=true
vim.opt.number=true
vim.opt.termguicolors=true
vim.opt.splitright=true
vim.opt.guifont="Droid Sans Mono for Powerline Nerd Font Complete"
vim.opt.updatetime=250
vim.keymap.set('i', '<C-j>', '<ESC>')

vim.api.nvim_create_autocmd(
  "VimEnter",
  { command = [[ NvimTreeToggle ]] }
)

vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'VonHeikemen/lsp-zero.nvim'
  use 'williamboman/nvim-lsp-installer'

  -- Auto-completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Color scheme
  use "cpea2506/one_monokai.nvim"

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- Others
  use 'petertriho/nvim-scrollbar'
  use 'kevinhwang91/nvim-hlslens'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
end)

require("one_monokai").setup()
require('gitsigns').setup()
require('scrollbar').setup()
require("scrollbar.handlers.search").setup()
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
    update_root = true
  },
  view = {
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
    centralize_selection = true
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  }
})

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()

-- Format on save
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

--
-- From https://github.com/neovim/nvim-lspconfig
--

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'dp', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', 'dn', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', 'dq', vim.diagnostic.setqflist, opts)
vim.api.nvim_create_autocmd(
	"CursorHold",
	{ command = [[lua vim.diagnostic.open_float()]] }
)
vim.api.nvim_create_autocmd(
	"CursorHoldI",
	{ command = [[silent! lua vim.lsp.buf.signature_help()]] }
)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

require('lspconfig')['gopls'].setup{ on_attach = on_attach }
require('lspconfig')['clangd'].setup{ on_attach = on_attach }
