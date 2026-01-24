-- C# / .NET development with Roslyn LSP and easy-dotnet.nvim
return {
  -- LSP progress indicator
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        display = {
          done_ttl = 5,
          progress_icon = { pattern = "dots", period = 1 },
        },
      },
    },
  },

  -- Disable noice's LSP progress (let fidget handle it)
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
      },
    },
  },

  -- Add custom Mason registry for Roslyn
  {
    "williamboman/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },

  -- Roslyn LSP for C#
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    opts = {
      -- Configuration options
      config = {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
            dotnet_enable_tests_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
          },
        },
      },
      -- Broad file matching for Roslyn
      broad_search = true,
      -- Lock file for solution tracking
      lock_target = true,
    },
  },

  -- Easy Dotnet - project management, test runner, debugging
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    ft = { "cs", "fsproj", "csproj", "sln" },
    config = function()
      require("easy-dotnet").setup({
        -- Enable Roslyn LSP integration
        roslyn = {
          enable = true,
        },
        -- Test runner configuration
        test_runner = {
          viewmode = "float",
          enable_buffer_test_execution = true,
          icons = {
            passed = "",
            skipped = "",
            failed = "",
            success = "",
            reload = "",
            test = "",
            sln = "󰘐",
            project = "󰘐",
            dir = "",
            package = "",
          },
        },
        -- Auto-bootstrap namespace for new C# files
        auto_bootstrap_namespace = {
          enabled = true,
        },
      })
    end,
    keys = {
      { "<leader>dn", "<cmd>lua require('easy-dotnet').create_new_item()<cr>", desc = "Dotnet: New Item" },
      { "<leader>dR", "<cmd>lua require('easy-dotnet').run_project()<cr>", desc = "Dotnet: Run Project" },
      { "<leader>dj", "<cmd>lua require('easy-dotnet').restore()<cr>", desc = "Dotnet: Restore" },
      { "<leader>db", "<cmd>lua require('easy-dotnet').build()<cr>", desc = "Dotnet: Build" },
      { "<leader>dc", "<cmd>lua require('easy-dotnet').clean()<cr>", desc = "Dotnet: Clean" },
      { "<leader>dt", "<cmd>lua require('easy-dotnet').test_project()<cr>", desc = "Dotnet: Test Project" },
      { "<leader>dT", "<cmd>lua require('easy-dotnet').test_solution()<cr>", desc = "Dotnet: Test Solution" },
      { "<leader>ds", "<cmd>lua require('easy-dotnet').solution_select()<cr>", desc = "Dotnet: Select Solution" },
      { "<leader>dp", "<cmd>lua require('easy-dotnet').project_select()<cr>", desc = "Dotnet: Select Project" },
    },
  },

  -- Treesitter for C#
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "c_sharp" })
    end,
  },
}
