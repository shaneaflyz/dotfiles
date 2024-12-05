return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = function(_, opts)
    opts.presets = { lsp_doc_border = true }
    opts.debug = false
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = {
        event = 'notify',
        find = 'No information available',
      },
      opts = { skip = true },
    })
    local focused = true
    vim.api.nvim_create_autocmd('FocusGained', {
      callback = function()
        focused = true
      end,
    })
    vim.api.nvim_create_autocmd('FocusLost', {
      callback = function()
        focused = false
      end,
    })

    table.insert(opts.routes, 1, {
      filter = {
        ['not'] = {
          event = 'lsp',
          kind = 'progress',
        },
        cond = function()
          return not focused
        end,
      },
      view = 'notify_send',
      opts = { stop = false },
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(event)
        vim.schedule(function()
          require('noice.text.markdown').keys(event.buf)
        end)
      end,
    })
    return opts
  end,
}
