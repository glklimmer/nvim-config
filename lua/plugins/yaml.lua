return {
  {
    "cuducos/yaml.nvim",
    ft = { "yaml", "yml" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      vim.api.nvim_create_user_command("YAMLView", function()
        require("yaml_nvim").view()
      end, { desc = "YAML: View" })

      vim.api.nvim_create_user_command("YAMLTelescope", function()
        require("yaml_nvim").telescope()
      end, { desc = "YAML: Telescope" })

      -- Set up key mappings only in YAML files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "yaml", "yml" },
        callback = function()
          vim.keymap.set("n", "<S-K>", function()
            require("yaml_nvim").view()
          end, {
            buffer = true,
            desc = "YAML: View",
          })
          vim.keymap.set("n", "/", function()
            require("yaml_nvim").telescope()
          end, {
            buffer = true,
            desc = "YAML: Telescope",
          })
        end,
      })
    end,
  },
}
