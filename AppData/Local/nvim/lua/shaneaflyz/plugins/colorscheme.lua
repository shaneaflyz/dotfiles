return {
  -- {
  --   'sainnhe/gruvbox-material',
  --   priority = 1000,
  --   init = function()
  --     vim.g.gruvbox_material_transparent_background = 1
  --     vim.g.gruvbox_material_foreground = 'mix'
  --     vim.g.gruvbox_material_background = 'medium'
  --     vim.g.gruvbox_material_ui_contrast = 'high'
  --     vim.g.gruvbox_material_float_style = 'bright'
  --     vim.g.gruvbox_material_statusline_style = 'material'
  --     vim.g.gruvbox_material_cursor = 'auto'
  --     vim.g.gruvbox_material_colors_override = { bg0 = '#16181A' } -- #0e1010
  --
  --     vim.cmd.colorscheme 'gruvbox-material'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  -- {
  --   'rose-pine/neovim',
  --   priority = 1000,
  --   name = 'rose-pine',
  --   config = function()
  --     require('rose-pine').setup {
  --       {
  --         styles = {
  --           bold = true,
  --           italic = false,
  --           transparency = true,
  --         },
  --       },
  --     }
  --     vim.cmd 'colorscheme rose-pine-moon'
  --   end,
  -- },

  -- {
  --   'EdenEast/nightfox.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('nightfox').setup {
  --       options = {
  --         -- Compiled file's destination location
  --         compile_path = vim.fn.stdpath 'cache' .. '/nightfox',
  --         compile_file_suffix = '_compiled', -- Compiled file suffix
  --         transparent = true, -- Disable setting background
  --         terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
  --         dim_inactive = false, -- Non focused panes set to alternative background
  --         module_default = true, -- Default enable value for modules
  --         colorblind = {
  --           enable = false, -- Enable colorblind support
  --           simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
  --           severity = {
  --             protan = 0, -- Severity [0,1] for protan (red)
  --             deutan = 0, -- Severity [0,1] for deutan (green)
  --             tritan = 0, -- Severity [0,1] for tritan (blue)
  --           },
  --         },
  --         styles = { -- Style to be applied to different syntax groups
  --           comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
  --           conditionals = 'NONE',
  --           constants = 'NONE',
  --           functions = 'NONE',
  --           keywords = 'NONE',
  --           numbers = 'NONE',
  --           operators = 'NONE',
  --           strings = 'NONE',
  --           types = 'NONE',
  --           variables = 'NONE',
  --         },
  --         inverse = { -- Inverse highlight for different types
  --           match_paren = false,
  --           visual = false,
  --           search = false,
  --         },
  --         modules = { -- List of various plugins and additional options
  --           -- ...
  --         },
  --       },
  --     }
  --     vim.cmd 'colorscheme terafox'
  --   end,
  -- },

  -- {
  --   'ilof2/posterpole.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('posterpole').setup {
  --       transparent = false,
  --       colorless_bg = false, -- grayscale or not
  --       dim_inactive = false, -- highlight inactive splits
  --       brightness = 2, -- negative numbers - darker, positive - lighter
  --       selected_tab_highlight = false, --highlight current selected tab
  --       fg_saturation = 14, -- font saturation, gray colors become more brighter
  --       bg_saturation = -2, -- background saturation
  --       colors = {
  --         posterpole = {}, -- { mainRed = "#550000" }
  --         posterpole_term = {}, -- { mainRed = 95 }
  --       },
  --       lualine = {
  --         transparent = false,
  --       },
  --     }
  --     vim.cmd 'colorscheme posterpole'
  --
  --     -- if you need colorscheme without termguicolors support
  --     -- This variant set termguicolors to false, be aware of using it
  --     -- vim.cmd("colorscheme posterpole-term")
  --   end,
  -- },

  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      local transparent = true -- set to true if you would like to enable transparency

      local bg = '#011628'
      local bg_dark = '#011423'
      local bg_highlight = '#143652'
      local bg_search = '#0A64AC'
      local bg_visual = '#275378'
      local fg = '#CBE0F0'
      local fg_dark = '#B4D0E9'
      local fg_gutter = '#627E97'
      local border = '#547998'

      require('tokyonight').setup {
        style = 'night',
        transparent = transparent,
        styles = {
          sidebars = transparent and 'transparent' or 'dark',
          floats = transparent and 'transparent' or 'dark',
        },
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = transparent and colors.none or bg_dark
          colors.bg_float = transparent and colors.none or bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = transparent and colors.none or bg_dark
          colors.bg_statusline = transparent and colors.none or bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      }

      vim.cmd 'colorscheme tokyonight'
    end,
  },

  -- {
  --   'catppuccin/nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('catppuccin').setup {
  --       transparent_background = true,
  --     }
  --     vim.cmd.colorscheme 'catppuccin-mocha'
  --   end,
  -- },
}
