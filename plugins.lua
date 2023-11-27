local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- defaults 
        "vim",
        "lua",

        -- web dev 
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        -- "vue", "svelte",

        -- low level
        "c",
        "rust",
        "zig",

        -- data science
        "python",
      },
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "neovim/nvim-lspconfig",

     dependencies = {
       "jose-elias-alvarez/null-ls.nvim",
       config = function()
         require "custom.configs.null-ls"
       end,
     },

     config = function()
        require "plugins.configs.lspconfig"
        require "custom.configs.lspconfig"
     end,
  },
  {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "lua-language-server",
        "html-lsp",
        "prettier",
        "rust-analyzer",
        "mypy",
        "pyright",
        "ruff",
        "black",
        "stylua"
      },
    },
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end,
    init = function()
      require("core.utils").load_mappings("rust_tools")
    end
  },
  {
    "mfussenegger/nvim-dap",

    dependencies = {

      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        opts = {},
        config = function(_, opts)
          -- setup dap config by VsCode launch.json file
          -- require("dap.ext.vscode").load_launchjs()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
          },
        },
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            "python",
            "rust",
            -- Update this to ensure that you have the debuggers for the langs you want

          },
        },
      },
    },

    -- stylua: ignore
    keys = {
      { "<leader>dB",
        function() require("dap").set_breakpoint(
          vim.fn.input('Breakpoint condition: ')) end,
        desc = "Breakpoint Condition" },
      { "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint" },
      { "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue" },
      { "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor" },
      { "<leader>dg",
        function() require("dap").goto_() end,
        desc = "Go to line (no execute)" },
      { "<leader>di",
        function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj",function() require("dap").down() end, desc = "Down" },
      { "<leader>dk",
        function() require("dap").up() end, desc = "Up" },
      { "<leader>dl",
        function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do",
        function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO",
        function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp",function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr",
        function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds",
        function() require("dap").session() end, desc = "Session" },
      { "<leader>dt",
        function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw",
        function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },

    -- config = function()
    --   local Config = require("lazyvim.config")
    --   vim.api.nvim_set_hl(0, "DapStoppedLine",
    --     { default = true, link = "Visual" })
    --
    --   for name, sign in pairs(Config.icons.dap) do
    --     sign = type(sign) == "table" and sign or { sign }
    --     vim.fn.sign_define(
    --       "Dap" .. name,
    --       { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --     )
    --   end
    -- end,
  },
}
return plugins
