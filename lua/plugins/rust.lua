return {
  -- disable inline hints
  {

    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },

  -- add bacon
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "bacon" })
    end,
  },
  {
    "Canop/nvim-bacon",
    config = function()
      require("bacon").setup({
        quickfix = {
          enabled = true, -- Enable Quickfix integration
          event_trigger = true, -- Trigger QuickFixCmdPost after populating Quickfix list
        },
      })
    end,
  },

  -- nicer rust diagnostics
  {
    "alexpasmantier/krust.nvim",
    ft = "rust",
    opts = {
      float_win = {
        border = "solid",
      },
    },
    config = function(_, opts)
      require("krust").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          vim.keymap.set("n", "<leader>cd", "<cmd>Krust<CR>", { desc = "Krust diagnostics", buffer = true })
        end,
      })
    end,
  },
}
