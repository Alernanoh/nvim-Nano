vim.pack.add {
  { src = 'https://github.com/saghen/blink.lib', version = vim.version.range '1.*' },
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
}
require('blink.cmp').setup {
  keymap = {
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_next', 'fallback_to_mappings' },
    ['<S-Tab>'] = { 'select_prev', 'fallback_to_mappings' },
    ['<C-p>'] = { 'snippet_forward', 'fallback' },
    ['<C-n>'] = { 'snippet_backward', 'fallback' },
    ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  completion = {
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },
  snippets = { preset = 'luasnip' },
  fuzzy = { implementation = 'lua' },
  signature = { enabled = true },
}
