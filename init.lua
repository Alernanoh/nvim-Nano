vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.opt.updatetime = 500
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.showmode = false
-- Show diagnostics on cursor instead of pressing the keybind
vim.diagnostic.config {
  float = { border = 'rounded' },
}

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking',
  group = vim.api.nvim_create_augroup('highligh-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Adding pluggins setups
require 'plugins.telescope'
require 'plugins.catppuccin'
require 'plugins.mini'
require 'plugins.mason'
require 'plugins.keybinds'
require 'plugins.gitsigns'
require 'plugins.guess-indent'
require 'plugins.whichkey'
require 'plugins.conform'
require 'plugins.luasnip'
require 'plugins.treesitter'
require 'plugins.blink'

vim.cmd.colorscheme 'catppuccin-nvim'
