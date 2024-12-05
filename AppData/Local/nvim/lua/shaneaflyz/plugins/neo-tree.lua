-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  lazy = false,
  priority = 9000,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      hijack_netrw_behavior = 'open_current',
      window = {
        position = 'left',
        width = 26,
        mappings = {
          ['\\'] = 'close_window',
          ['<space>'] = {
            'toggle_node',
            nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('neo-tree').setup(opts)
    -- removes the "Window settings restored" message
    vim.api.nvim_del_augroup_by_name 'NeoTree_BufLeave'
    local bufenter = function(data)
      local pattern = 'neo%-tree [^ ]+ %[1%d%d%d%]'
      if string.match(data.file, pattern) then
        vim.w.neo_tree_alternate_nr = vim.fn.bufnr '#' ---@diagnostic disable-line: param-type-mismatch
      end
    end
    vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
      group = vim.api.nvim_create_augroup('NeoTree_BufEnter', { clear = true }),
      pattern = 'neo-tree *',
      callback = bufenter,
    })
  end,
}
