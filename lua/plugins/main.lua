return {
  -- tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  -- neotest binding
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        ["<leader>t"] = { name = "+test" },
      },
    },
  },

  -- status line bottom
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      local mode = require("noice").api.status.mode

      opts.sections.lualine_x = {
        {
          mode.get,
          cond = mode.has,
          color = { fg = "#ff9e64" },
        },
      }

      opts.sections.lualine_y = {
        { "location", padding = { left = 0, right = 1 } },
      }
      opts.sections.lualine_z = {}
      opts.extensions = { "neo-tree", "lazy" }

      return opts
    end,
  },

  -- disable flash on search with /
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        -- options used when flash is activated through
        -- a regular search with `/` or `?`
        search = {
          -- when `true`, flash will be activated during regular search by default.
          -- You can always toggle when searching with `require("flash").toggle()`
          enabled = false,
        },
      },
    },
  },
}
