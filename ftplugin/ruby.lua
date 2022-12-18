--=============================================================================
-------------------------------------------------------------------------------
--                                                                         RUBY
--=============================================================================
-- Loaded when a ruby file is oppened.
--_____________________________________________________________________________

require("filetype")
  .new({
    copilot = true,
    -- gem install solargraph
    lsp_server = "solargraph",
    -- gem install rubocop
    linter = "robocop",
    -- gem install rubocop
    formatter = function()
      return {
        exe = "rubocop",
        args = {
          "--fix-layout",
          "--stdin",
          vim.api.nvim_buf_get_name(0),
          "--format",
          "files",
        },
        stdin = true,
        transform = function(text)
          table.remove(text, 1)
          table.remove(text, 1)
          return text
        end,
      }
    end,
    actions = {
      ["Run current Ruby file"] = function()
        return {
          filetypes = { "ruby" },
          steps = {
            { "ruby", vim.api.nvim_buf_get_name(0) },
          },
        }
      end,
    },
  })
  :load()
