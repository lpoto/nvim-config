--=============================================================================
-------------------------------------------------------------------------------
--                                                         TELESCOPE-TASKS-NVIM
--=============================================================================
-- https://github.com/lpoto/telescope-tasks.nvim
--_____________________________________________________________________________

--[[
Synchronous tasks from a telescope prompt.

Keymaps:
  - "<leader>a" - Open the tasks prompt
  - "<leader>e" - Toggle latest output
--]]

local M = {
  "lpoto/telescope-tasks.nvim",
  dev = true,
  dir = "/home/luka/personal/telescope-tasks.nvim",
}

function M.init()
  vim.keymap.set("n", "<leader>a", function()
    require("telescope").extensions.tasks.tasks()
  end)
  vim.keymap.set("n", "<leader>e", function()
    require("telescope").extensions.tasks.actions.toggle_last_output()
  end)
end

function M.config()
  local telescope = require "telescope"
  telescope.setup {
    extensions = {
      tasks = {
        theme = "dropdown",
      },
    },
  }

  telescope.load_extension "tasks"

  telescope.extensions.tasks.generators.enable_default()
end

return M