--=============================================================================
-------------------------------------------------------------------------------
--                                                                     MARKDOWN
--=============================================================================
-- Loaded when a markdown file is oppened.
--_____________________________________________________________________________

require("filetype")
  .new({
    copilot = true,
    -- npm install -g prettier
    formatter = function()
      return {
        exe = "prettier",
        args = {
          vim.api.nvim_buf_get_name(0),
        },
        stdin = true,
      }
    end,
  })
  :load()
