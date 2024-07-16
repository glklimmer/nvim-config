return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          setup = {
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = "/path/to/@vue/language-server",
                  languages = { "vue" },
                },
              },
            },
          },
        },
        volar = {
          setup = {
            init_options = {
              vue = {
                hybridMode = false,
              },
            },
          },
        },
      },
    },
  },
}
