return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    require('orgmode').setup {
      org_todo_keywords = { 'TODO', 'WAITING', '|', 'DONE', 'DELEGATED' },
      org_todo_keyword_faces = {
        WAITING = ':foreground blue :weight bold',
        DELEGATED = ':background #FFFFFF :slant italic :underline on',
      },
      org_agenda_files = '~/Documents/orgfiles/',
      org_default_notes_file = '~/Documents/orgfiles/refile.org',
    }
  end,
}
