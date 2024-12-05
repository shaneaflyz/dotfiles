return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'moll/vim-bbye' },
  opts = {
    options = {
      mode = 'buffers',
      show_close_icon = true,
      close_icon = ' ',
      color_icons = true,
      tab_size = 21,
      max_name_length = 30,
      max_prefix_length = 30,
      indicator = {
        style = 'none',
      },
      always_show_bufferline = true,
      show_tab_indicators = false,
      enforce_regular_tabs = true,
      themable = false,
      diagnostics = 'nvim_lsp',
      minimum_padding = 1,
      maximum_padding = 5,
      maximum_length = 15,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo Tree ~',
          text_align = 'center',
          separator = false,
        },
      },
    },
    highlights = {
      buffer_selected = {
        bold = true,
        italic = false,
      },
    },
  },
}
