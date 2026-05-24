vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
}
require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

require('mini.surround').setup {}
require('mini.pairs').setup {}
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
