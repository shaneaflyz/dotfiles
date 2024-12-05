-- for plugins that DO NOT require any/much configuration

return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  { 'Bilal2453/luvit-meta', lazy = true },
}
