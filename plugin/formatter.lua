--=============================================================================
-------------------------------------------------------------------------------
--                                                               FORMATTER.NVIM
--=============================================================================
-- https://github.com/mhartington/formatter.nvim
--_____________________________________________________________________________

local plugin = require("plugin").new {
  "mhartington/formatter.nvim",
  as = "formatter",
  cmd = { "Format", "FormatWrite", "FormatLock", "FormatWriteLock" },
  keys = { "<leader>f" },
  config = function(formatter)
    formatter.setup {
      logging = true,
      log_level = vim.log.levels.INFO,
      filetype = {
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace,
        },
      },
    }
  end,
}

-- format with "<leader>f""
plugin:config(function()
  vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>FormatWriteLock<CR>", {
    noremap = true,
  })
end)