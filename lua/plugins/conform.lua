vim.pack.add {
  'https://github.com/stevearc/conform.nvim',
}
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local enabled_filetypes = {
      lua = true,
      python = true,
      go = true,
      rust = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    -- Add external formatters
    -- rust = {'rustfmt'}
  },
}
vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
