return {
  -- git signs on the side, also git blame (custom key map)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        -- stylua: ignore end
      end,
    },
  },

  -- gitlab nvim
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      enabled = true,
    },
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    config = function()
      local gitlab = require("gitlab")
      gitlab.setup({
        reviewer = "diffview",
      })

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map("n", "<leader>glr", gitlab.review, "review")
      map("n", "<leader>gls", gitlab.summary, "summary")
      map("n", "<leader>glA", gitlab.approve, "approve")
      map("n", "<leader>glR", gitlab.revoke, "revoke")
      map("n", "<leader>glc", gitlab.create_comment, "create comment")
      map("n", "<leader>gln", gitlab.create_note, "create note")
      map("n", "<leader>gld", gitlab.toggle_discussions, "toggle discussions")
      map("n", "<leader>glaa", gitlab.add_assignee, "add assignee")
      map("n", "<leader>glad", gitlab.delete_assignee, "delete assignee")
      -- map("n", "<leader>glra", gitlab.add_reviewer, "add reviewer")
      -- map("n", "<leader>glrd", gitlab.delete_reviewer, "delete reviewer")
      map("n", "<leader>glp", gitlab.pipeline, "pipeline")
      map("n", "<leader>glo", gitlab.open_in_browser, "open in browser")
    end,
  },

  -- git diffview
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>fh",
        ":DiffviewFileHistory %<CR>",
        { noremap = true, silent = true, desc = "File (git) history" }
      )
    end,
  },
}
