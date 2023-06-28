-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',

  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      require('config.nvim-cmp')
    end,
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = { require('config.barbar') },
  },
  'bluz71/nvim-linefly',

  { 'folke/which-key.nvim',      opts = {} },

  { 'numToStr/Comment.nvim',     opts = {} },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.telescope')
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('config.treesitter')
    end,
    build = ':TSUpdate',
  },

  'Raimondi/delimitMate',
  -- {
  --   'windwp/nvim-autopairs',
  --   opts = {
  --     fast_wrap = {},
  --     disable_filetype = { 'TelescopePrompt', 'vim' },
  --   },
  --   config = function(_, opts)
  --     require('nvim-autopairs').setup(opts)
  --     local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  --     require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
  --   end,
  -- },

  require 'plugins.autoformat'
})
