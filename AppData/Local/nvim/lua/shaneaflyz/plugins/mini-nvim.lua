return {
  -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects

    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - c  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)

    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.animate').setup {
      resize = {
        timing = require('mini.animate').gen_timing.linear { duration = 50, unit = 'total' },
      },
      scroll = {
        timing = require('mini.animate').gen_timing.linear { duration = 150, unit = 'total' },
      },
      cursor = {
        timing = require('mini.animate').gen_timing.linear { duration = 150, unit = 'total' },
      },
    }
  end,
}
