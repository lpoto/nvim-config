--=============================================================================
-------------------------------------------------------------------------------
--                                                               NVIM-LSPCONFIG
--[[===========================================================================
https://github.com/neovim/nvim-lspconfig

Configuration for the built-in LSP client.
see github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
for server configurations.
Lsp is then enabled with ':LspStart' (this is usually done automatically for
filetypes in ftplguin/)


Keymaps:
  - "gd"    - jump to the definition of the symbol under cursor
  - "K" -  Show the definition of symbol under the cursor
  - "<C-d>" -  Show the diagnostics of the line under the cursor
-----------------------------------------------------------------------------]]
local M = {
  "neovim/nvim-lspconfig",
  cmd = { "LspStart", "LspInfo" },
}

function M.init()
  vim.keymap.set("n", "K", vim.lsp.buf.hover)
  vim.keymap.set("n", "<C-d>", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition)
end

local expand_opts

---Start the provided language server, if no opts
---are provided, {} will be used.
---opts.capabilities will be automatically set to
---cmp's default capabilities if not found.
---@param opts table|string?: Optional server configuration
function M.start_language_server(opts)
  local server
  server, opts = expand_opts(opts)
  if not server or server:len() == 0 then
    Util.log():warn "No server provided"
    return
  end

  vim.schedule(function()
    Util.require("lspconfig", function(lspconfig)
      local lsp = lspconfig[server]
      if lsp == nil then
        Util.log():warn("Language server not found:", server)
        return
      end

      opts = vim.tbl_deep_extend(
        "force",
        opts or {},
        vim.g[server .. "_config"] or {}
      )

      opts.capabilities = opts.capabilities
        or Util.require("plugins.cmp", function(cmp)
          return cmp.capabilities()
        end)

      lsp.setup(opts)

      vim.api.nvim_exec("LspStart", true)
    end)
  end)
end

function expand_opts(opts)
  local server = opts
  if type(opts) ~= "table" then
    opts = {}
  end

  if type(server) == "table" then
    server = opts.name
  end
  if type(server) ~= "string" and type(opts) == "table" then
    server = opts.server
  end
  if type(server) ~= "string" and type(opts) == "table" then
    server = opts[1]
  end
  if type(opts) ~= "table" then
    opts = {}
  end
  if type(server) ~= "string" then
    server = ""
  end
  return server, opts
end

return M
