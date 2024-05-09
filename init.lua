-- My basic settings
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
vim.diagnostic.config({
  virtual_text = false
})

vim.g.rustfmt_autosave = 1

vim.api.nvim_create_autocmd(
  "VimEnter",
  { command = [[ NvimTreeToggle ]] }
)

vim.api.nvim_create_autocmd(
  "VimEnter",
  { command = [[ SymbolsOutline ]] }
)

vim.api.nvim_create_autocmd(
  "BufEnter",
  { command = [[ CoverageLoad ]] }
)

vim.api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Per-language preference
vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp" },
  callback = function(args)
    vim.o.expandtab = false
    vim.o.shiftwidth = 8
    vim.o.tabstop = 8
    vim.o.softtabstop = 8
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
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

  use 'williamboman/nvim-lsp-installer'

  -- Rust
  use 'rust-lang/rust.vim'

  -- Zig
  use {'ziglang/zig.vim'}

  -- Auto-completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- Color scheme
  use "cpea2506/one_monokai.nvim"

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use "sindrets/diffview.nvim"

  -- Symbol outline
  use 'simrat39/symbols-outline.nvim'

  -- Fuzzy Search
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  -- Test
  use 'vim-test/vim-test'
  use 'andythigpen/nvim-coverage'

  -- Debug
  use 'mfussenegger/nvim-dap'
  use {'rcarriga/nvim-dap-ui', requires={"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}}
  use 'leoluz/nvim-dap-go'
  use 'ldelossa/nvim-dap-projects'

  -- Auto pair
  use 'windwp/nvim-autopairs'

  -- Copilot
  use {'zbirenbaum/copilot.lua'}

  -- ChatGPT
  use({
  "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- File viewer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
  }

  -- Status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- UI
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
require("nvim-tree").setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  update_focused_file = {
    enable = true,
    update_root = true
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  }
})

local telescope = require('telescope')
telescope.load_extension "ui-select"

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

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
	{ command = [[lua vim.diagnostic.open_float(nil, {focus=false})]] }
)
vim.api.nvim_create_autocmd(
	"CursorHoldI",
	{ command = [[silent! lua vim.lsp.buf.signature_help()]] }
)

--
-- LSP settings
--

require('lspconfig').gopls.setup{
	settings = {
		gopls = {
      			analyses = {
				shadow = true,
				unusedvariable = true,
				unusedwrite = true,
				useany = true,
      			},
			hints = {
				parameterNames = true,
				assignVariableTypes = true,
			},
      			staticcheck = true,
    		},
	},
}
require("lspconfig").clangd.setup {
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
require('lspconfig').rust_analyzer.setup{}
require('lspconfig').zls.setup{ on_attach = on_attach }
require('lspconfig').ltex.setup{
	settings = {
		ltex = {
			language = "en-US",
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "ja-JP",
				languageModel = "/home/yutaro/.local/share/language-tool-ngram-models",
			},
		},
	},
}
require('lspconfig').pyright.setup{}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    vim.keymap.set('n', 'qq', function()
      vim.lsp.buf.code_action({
      filter = function(a) return a.isPreferred end,
        apply = true
      })
    end, opts)
  end,
})

--
-- Completion settings
--
local cmp=require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

require('coverage').setup()

require('dap')
require('dapui').setup()
require('dap-go').setup()
require('nvim-dap-projects').search_project_config()
-- nvim-dap
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open({height=10}) end)
vim.keymap.set('n', '<leader>l', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { silent = true})
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)

-- nvim-test
vim.keymap.set('n', '<Leader>t', ':TestNearest -test.v<CR>')
-- vim.keymap.set('n', '<Leader>t', ':TestNearest -- --show-output<CR>')

require("symbols-outline").setup()
require("nvim-autopairs").setup()
require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-k>",
      next = "<C-]>",
      prev = "<C-[>",
      dismiss = "<M-]>",
    },
  },
  filetype = {
	  markdown = true,
	  gitcommit = true,
	  gitrebase = true,
  },
})

require("chatgpt").setup({})
