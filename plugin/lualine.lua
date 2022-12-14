--=============================================================================
-------------------------------------------------------------------------------
--                                                                 LUALINE.NVIM
--=============================================================================
-- https://github.com/nvim-lualine/lualine.nvim
--_____________________________________________________________________________

require("plugin").new {
  "nvim-lualine/lualine.nvim",
  as = "lualine",
  event = "BufNewFile,BufReadPre",
  config = function(lualine)
    lualine.setup {
      options = {
        theme = "gruvbox-material",
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "filename" },
        lualine_c = { "filetype" },
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      tabline = {
        lualine_a = { "branch" },
        lualine_b = { "encoding" },
        lualine_c = {
          { "diagnostics", sources = { "nvim_diagnostic", "vim_lsp" } },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { { "tabs", mode = 2 } },
      },
    }
  end,
}