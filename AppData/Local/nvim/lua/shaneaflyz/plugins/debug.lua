-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
    {
      'microsoft/vscode-js-debug',
      build = (function()
        if vim.loop.os_uname().sysname == 'Windows_NT' then
          return 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle &&  (if exist out rmdir /s /q out) && move dist out'
        else
          return 'npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out'
        end
      end)(),
      version = '1.*',
    },
    'mxsdev/nvim-dap-vscode-js',
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'js',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }

    --
    require('dap-vscode-js').setup {
      node_path = 'node',
      debugger_path = vim.fn.stdpath 'data' .. '\\lazy\\vscode-js-debug',
      adapters = {
        'chrome',
        'pwa-node',
        'pwa-chrome',
        'pwa-msedge',
        'pwa-extensionHost',
        'node-terminal',
      },
    }
    local js_based_languages = {
      'typescript',
      'javascript',
      'typescriptreact',
      'javascriptreact',
      'vue',
    }
    for _, language in ipairs(js_based_languages) do
      dap.configurations[language] = {
        -- Debug single nodejs files
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
        },
        -- Debug web applications (client side)
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch & Debug Chrome',
          url = function()
            local co = coroutine.running()
            return coroutine.create(function()
              vim.ui.input({
                prompt = 'Enter URL: ',
                default = vim.g.default_website_launch,
              }, function(url)
                if url == nil or url == '' then
                  return
                else
                  vim.g.default_website_launch = url
                  coroutine.resume(co, url)
                end
              end)
            end)
          end,
          webRoot = vim.fn.getcwd(),
          protocol = 'inspector',
          sourceMaps = true,
          userDataDir = false,
        },
      }
    end

    -- for _, adapters in ipairs { 'pwa-chrome' } do
    --   dap.adapters[adapters] = {
    --     {
    --       type = 'server',
    --       host = 'localhost',
    --       port = '${port}',
    --       executable = {
    --         command = 'node',
    --         args = {
    --           require('mason-registry').get_package('js-debug-adapter'):get_install_path() .. '\\js-debug\\src\\dapDebugServer.js',
    --           '${port}',
    --         },
    --       },
    --     },
    --   }
    -- end
    -- for _, lang in ipairs {
    --   'typescript',
    --   'javascript',
    --   'typescriptreact',
    --   'javascriptreact',
    -- } do
    --   dap.configurations[lang] = dap.configurations[lang] or {}
    --   table.insert(dap.configurations[lang], {
    --     type = 'pwa-chrome',
    --     request = 'launch',
    --     name = 'Launch Chrome',
    --     url = 'http://localhost:9000',
    --     sourceMaps = true,
    --     webRoot = vim.fn.getcwd(),
    --   })
    -- end
    --
    -- for _, language in ipairs { 'typescriptreact', 'typescript', 'javascriptreact', 'javascript' } do
    --   dap.configurations[language] = {
    --     {
    --
    --       type = 'chrome',
    --       request = 'attach',
    --       url = 'http://local:9000',
    --       program = '${file}',
    --       cwd = vim.fn.getcwd(),
    --       sourceMaps = true,
    --       protocol = 'inspector',
    --       port = 9222,
    --       webRoot = '${workspaceFolder}',
    --     },
    -- }
    -- end
  end,
}
