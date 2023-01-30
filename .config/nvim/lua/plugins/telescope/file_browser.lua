--=============================================================================
-------------------------------------------------------------------------------
--                                                       TELESCOPE-FILE_BROWSER
--=============================================================================
-- https://github.com/nvim-telescope/telescope-file-browser.nvim
--_____________________________________________________________________________
--[[

Keymaps:
 - "<leader>tb"   - file browser relative to current file
 - "<leader>tB"   - file browser relative to current directory

--]]

local M = {
  "nvim-telescope/telescope-file-browser.nvim",
  keys = { "<leader>tb", "<leader>tB" },
}

function M.init()
  vim.keymap.set("n", "<leader>tb", function()
    require("telescope").extensions.file_browser.file_browser {
      path = "%:p:h",
    }
  end)
  vim.keymap.set("n", "<leader>tB", function()
    require("telescope").extensions.file_browser.file_browser()
  end)
end

function M.config()
  local telescope = require "telescope"
  telescope.setup {
    extensions = {
      file_browser = {
        theme = "ivy",
        hidden = true,
        initial_mode = "normal",
        hijack_netrw = true,
        grouped = true,
      },
    },
  }

  telescope.load_extension "file_browser"
end

return M
