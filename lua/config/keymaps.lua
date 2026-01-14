-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Tmux navigation
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { silent = true })

-- Define a function to open terminal with an optional command
function Start_console(command)
  local cmd = command and ("term " .. command) or "term"
  vim.cmd(cmd)
  vim.cmd("startinsert")
  vim.cmd(":setlocal nonumber norelativenumber")
end

-- Create a key mapping to call Start_console for a regular terminal
vim.api.nvim_set_keymap(
  "n",
  "<Leader>ft",
  ":lua Start_console()<CR>",
  { desc = "Terminal", noremap = true, silent = true }
)

-- Create a key mapping to call Start_console with "rails c"
vim.api.nvim_set_keymap(
  "n",
  "<Leader>rc",
  ":lua Start_console('rails c')<CR>",
  { desc = "Rails Console", noremap = true, silent = true }
)

-- Create a key mapping to call Start_console with "cargo run"
vim.api.nvim_set_keymap(
  "n",
  "<Leader>rr",
  ":lua Start_console('cargo run')<CR>",
  { desc = "Cargo run", noremap = true, silent = true }
)

-- Search within visial selection
vim.api.nvim_set_keymap(
  "v", -- Mode: visual mode
  "<M-/>", -- Key mapping: <M-/> (Alt + /)
  "<Esc>/\\%V", -- Command: Escape to normal mode, then start search within the visual selection
  { noremap = true, silent = true } -- Options: non-recursive mapping, silent execution
)

-- =========================
-- Filetype-specific "!" and "," mappings
-- Rust  -> Bacon
-- TS/Vue -> LSP diagnostics via Trouble
-- =========================

local map = LazyVim.safe_keymap_set

-- helper for buffer-local mappings
local function buf_map(bufnr, mode, lhs, rhs, opts)
  opts = opts or {}
  opts.buffer = bufnr
  map(mode, lhs, rhs, opts)
end

-- Rust: Bacon
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function(ev)
    buf_map(ev.buf, "n", "!", ":BaconLoad<CR>:w<CR>:BaconNext<CR>", {
      desc = "Next bacon location",
    })

    buf_map(ev.buf, "n", ",", ":BaconList<CR>", {
      desc = "Bacon locations list",
    })
  end,
})

-- TypeScript / Vue: Trouble
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "vue",
  },
  callback = function(ev)
    -- Next diagnostic (like BaconNext)
    buf_map(ev.buf, "n", "!", function()
      vim.cmd("write")
      vim.diagnostic.goto_next({ float = false })
    end, { desc = "Next diagnostic" })

    -- Diagnostics list via Trouble (buffer-local)
    buf_map(ev.buf, "n", ",", function()
      vim.cmd("Trouble diagnostics toggle filter.buf=0")
    end, { desc = "Diagnostics list (Trouble)" })
  end,
})
