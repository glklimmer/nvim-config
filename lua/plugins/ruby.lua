return {
  -- test
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          rspec_cmd = function()
            return vim.tbl_flatten({
              "bundle",
              "exec",
              "rspec",
            })
          end,
        },
      },
    },
  },

  -- use ruby lsp instead of solargraph
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          enabled = true,
        },
        solargraph = {
          enabled = false,
        },
        rubocop = {
          enabled = true,
        },
        standardrb = {
          enabled = false,
        },
      },
    },
  },
}
