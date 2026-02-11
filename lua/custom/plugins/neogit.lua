return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',

      'nvim-telescope/telescope.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', function()
        require('neogit').open()
      end, { desc = 'Open Neogit' })
    end,
  },
}
