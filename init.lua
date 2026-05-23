vim.loader.enable()
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.showmode = false

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking',
  group = vim.api.nvim_create_augroup('highligh-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Adding pluggins
vim.pack.add {
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/catppuccin/nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/L3MON4D3/LuaSnip',
}

vim.pack.add {
  { src = 'https://github.com/saghen/blink.lib', version = vim.version.range '1.*' },
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
}
-- Adding pluggins setups
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
require('gitsigns').setup {}
require('guess-indent').setup {}
require('which-key').setup {}
require('catppuccin').setup {
  flavour = 'mocha',
  transparent_background = true,
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
require('telescope').setup {
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
require('fidget').setup {}
require('mason').setup {}
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
require('luasnip').setup {}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })

local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }

vim.cmd.colorscheme 'catppuccin-nvim'

-- Telescope bindings:
local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Telescope LSP keybinds
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf

    vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

    vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

    vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

    vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

    vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

    vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

-- LSP keybinds and cursor highlight
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

--Adding lsp's
---@type table<string, vim.lsp.Config>
local servers = {
  clangd = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  stylua = {},
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
          --  See https://github.com/neovim/nvim-lspconfig/issues/3189
          library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
            '${3rd}/luv/library',
            '${3rd}/busted/library',
          }),
        },
      })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = {
      Lua = {
        format = { enable = false }, -- Disable formatting (formatting is done by stylua)
      },
    },
  },
}

-- Using Mason to install the lsp's
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {})

require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end
