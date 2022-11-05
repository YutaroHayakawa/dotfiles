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

-- Per-language preference
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { "c" },
--   callback = function(args)
--     vim.bo.expandtab = true
--     vim.bo.shiftwidth = 2
--     vim.bo.tabstop = 2
--     vim.bo.softtabstop = 2
--   end
-- })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "go" },
  callback = function(args)
    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
  end
})

--
-- Plugin settings
--
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

  -- Fuzzy Search
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Debugger
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'ldelossa/nvim-dap-projects'
  use 'leoluz/nvim-dap-go'

  -- Test
  use 'vim-test/vim-test'

  -- Others
  use 'petertriho/nvim-scrollbar'
  use 'kevinhwang91/nvim-hlslens'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }
  use 'zsugabubus/crazy8.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' } }
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }
end)

require("one_monokai").setup()
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = function(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
})
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
require('litee.lib').setup()
require('litee.gh').setup({
  -- deprecated, around for compatability for now.
  jump_mode   = "invoking",
  -- remap the arrow keys to resize any litee.nvim windows.
  map_resize_keys = false,
  -- do not map any keys inside any gh.nvim buffers.
  disable_keymaps = false,
  -- the icon set to use.
  icon_set = "default",
  -- any custom icons to use.
  icon_set_custom = nil,
  -- whether to register the @username and #issue_number omnifunc completion
  -- in buffers which start with .git/
  git_buffer_completion = true,
  -- defines keymaps in gh.nvim buffers.
  keymaps = {
      -- when inside a gh.nvim panel, this key will open a node if it has
      -- any futher functionality. for example, hitting <CR> on a commit node
      -- will open the commit's changed files in a new gh.nvim panel.
      open = "<CR>",
      -- when inside a gh.nvim panel, expand a collapsed node
      expand = "zo",
      -- when inside a gh.nvim panel, collpased and expanded node
      collapse = "zc",
      -- when cursor is over a "#1234" formatted issue or PR, open its details
      -- and comments in a new tab.
      goto_issue = "gd",
      -- show any details about a node, typically, this reveals commit messages
      -- and submitted review bodys.
      details = "d",
      -- inside a convo buffer, submit a comment
      submit_comment = "<C-s>",
      -- inside a convo buffer, when your cursor is ontop of a comment, open
      -- up a set of actions that can be performed.
      actions = "<C-a>",
      -- inside a thread convo buffer, resolve the thread.
      resolve_thread = "<C-r>",
      -- inside a gh.nvim panel, if possible, open the node's web URL in your
      -- browser. useful particularily for digging into external failed CI
      -- checks.
      goto_web = "gx"
  }
})

local telescope = require('telescope')
telescope.load_extension "ui-select"

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()

require('nvim-dap-projects').search_project_config()

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

require('lspconfig').gopls.setup{
	on_attach = on_attach,
	settings = {
		gopls = {
			buildFlags = {
				"-tags=integration_tests",
				-- "-tags=privileged_tests",
			},
		},
	},
}
require('lspconfig').clangd.setup{ on_attach = on_attach }
require('lualine').setup()
require('dap-go').setup()
