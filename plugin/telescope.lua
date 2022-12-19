--=============================================================================
-------------------------------------------------------------------------------
--                                                               NVIM-TELESCOPE
--=============================================================================
-- https://github.com/nvim-telescope/telescope.nvim
--_____________________________________________________________________________

--[[

Telescope is a highly extendable fuzzy finder over lists.
Items are shown in a popup with a prompt to search over.

Keymaps:
 - "<leader>n"   - find files
 - "<leader>g"   - live grep
 - "<leader>d"   - show diagnostics
 - "<leader>q"   - quickfix
 - "<C-n>"       - file explorer
 - "<C-x>"       - live grem for symbol under cursor
 - "<C-g>"       - git files

 Use <C-q> in a telescope prompt to send the results to quickfix.

NOTE:  telescope required rg (Ripgrep) and fd (Find) to be installed.
--]]

local plugin = require("plugin").new {
  "nvim-telescope/telescope.nvim",
  as = "telescope",
  keys = {
    "<leader>n",
    "<leader>q",
    "<leader>d",
    "<leader>g",
    "<C-n>",
    "<C-x>",
    "<C-g>",
  },
  module = "telescope",
  requires = {
    { "nvim-lua/plenary.nvim", module_pattern = { "plenary.*" } },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      module_pattern = "telescope",
    },
  },
  required_executables = { { "rg", "ripgrep" }, { "fd", "fd-find" } },
  config = function()
    local telescope = require "telescope"
    telescope.setup {
      defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = "🔍",
        color_devicons = true,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        mappings = {
          i = {
            -- NOTE: when a telescope window is opened, use ctrl + q to
            -- send the current results to a quickfix window, then immediately
            -- open quickfix in a telescope window
            ["<C-q>"] = function()
              require("telescope.actions").send_to_qflist(vim.fn.bufnr())
              require("telescope.builtin").quickfix()
            end,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--iglob",
            "!.git",
            "--hidden",
            "-u",
          },
          theme = "ivy",
          hidden = true,
          previewer = false,
          file_ignore_patterns = {
            "plugged/",
            ".undo/",
            ".local/",
            ".git/",
            "node_modules/",
            "target/",
            ".settings/",
            "dist/",
            ".angular/",
            "__pycache__",
          },
        },
      },
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
        },
      },
    }
    telescope.load_extension "file_browser"
  end,
}

---fuzzy find files with "<leader> + n"
---search word under cursor with "Ctrl + x"
---live grep with "<leader> + g" (REQUIRES 'ripgrep')
---open quickfix with "<leader> + q"
plugin:config(function()
  local mapper = require "mapper"

  mapper.map(
    "n",
    "<leader>n",
    "<cmd>lua require('telescope.builtin').find_files()<CR>"
  )
  mapper.map(
    "n",
    "<leader>q",
    "<cmd>lua require('telescope.builtin').quickfix()<CR>"
  )
  mapper.map(
    "n",
    "<leader>d",
    "<cmd>lua require('telescope.builtin').diagnostics()<CR>"
  )
  mapper.map(
    "n",
    "<C-x>",
    "<cmd>lua require('telescope.builtin').grep_string()<CR>"
  )
  mapper.map(
    "n",
    "<leader>g",
    "<cmd>lua require('telescope.builtin').live_grep()<CR>"
  )
  mapper.map(
    "n",
    "<C-g>",
    "<cmd>lua require('telescope.builtin').git_files()<CR>"
  )
  mapper.map(
    "n",
    "<C-n>",
    "<cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>"
  )
end)
