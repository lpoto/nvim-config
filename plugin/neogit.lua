--=============================================================================
-------------------------------------------------------------------------------
--                                                                     NVIM-DAP
--=============================================================================
-- https://github.com/TimUntersberger/neogit
--_____________________________________________________________________________

require("plugin").new {
  "TimUntersberger/neogit",
  as = "neogit",
  cmd = {"Git", "Neogit"}, -- Open the Neogit tab
  config = function(neogit)
    neogit.setup {
      disable_signs = true,
    }

    --NOTE: set :Git as the command for oppening neogit
    --Setup the :Git command exatcly the same as is :Neogit
    vim.api.nvim_create_user_command("Git", function(o)
      local ng = require "neogit"
      ng.open(require("neogit.lib.util").parse_command_args(o.fargs))
    end, {
      nargs = "*",
      desc = "Open Neogit",
      complete = function(arglead)
        local ng = require "neogit"
        return ng.complete(arglead)
      end,
    })
  end,
}