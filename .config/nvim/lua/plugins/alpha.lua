--=============================================================================
-------------------------------------------------------------------------------
--                                                                   ALPHA-NVIM
--[[===========================================================================
https://github.com/goolord/alpha-nvim

-----------------------------------------------------------------------------]]

local M = {
  "goolord/alpha-nvim",
  event = "User LazyVimStarted",
}

local button
local header
local buttons
local footer

function header()
  local ascii_file = vim.fn.stdpath("config") .. "/.storage/ascii_art.txt"
  local hdr = {}
  if vim.fn.filereadable(ascii_file) == 1 then
    local ok
    ok, hdr = pcall(vim.fn.readfile, ascii_file)
    if not ok then hdr = {} end
  else
    hdr = {
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠋⠉⣉⣉⠙⠿⠋⣠⢴⣊⣙⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⢀⠔⡩⠔⠒⠛⠧⣾⠊⢁⣀⣀⣀⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠛⠁⠀⠀⠀⠀⠀⡡⠊⠀⠀⣀⣠⣤⣌⣾⣿⠏⠀⡈⢿⡜⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠡⣤⣶⠏⢁⠈⢻⡏⠙⠛⠀⣀⣁⣤⢢⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠰⣄⡀⠣⣌⡙⠀⣘⡁⠜⠈⠑⢮⡭⠴⠚⠉⠀⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⠁⠀⢀⠔⠁⣀⣤⣤⣤⣤⣤⣄⣀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠁⠀⢀⣠⢠⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⡀⠀⢸⠀⢼⣿⣿⣶⣭⣭⣭⣟⣛⣛⡿⠷⠶⠶⢶⣶⣤⣤⣤⣶⣶⣾⡿⠿⣫⣾⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠈⠉⠉⠉⠉⠉⠙⠛⠛⠻⠿⠿⠿⠷⣶⣶⣶⣶⣶⣶⣶⣶⡾⢗⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⣀⣀⣀⡀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣝⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿]],
    }
  end
  local h = {}
  local n = math.floor((vim.api.nvim_win_get_height(0) - (12 + #hdr)) / 2)
  if n > 2 then
    n = math.floor(n / 2)
    for _ = 1, n do
      table.insert(h, "")
    end
  end
  for _, s in ipairs(hdr) do
    table.insert(h, s)
  end
  return {
    type = "text",
    val = h,
    opts = {
      position = "center",
      hl = "Comment",
    },
  }
end

function buttons()
  return {
    type = "group",
    val = {
      button("<leader>s", "Sessions", "Sessions"),
      button(
        "<leader>o",
        "Old Files",
        function() require("telescope.builtin").oldfiles() end
      ),
      button(
        "<leader>n",
        "Find Files",
        function() require("telescope.builtin").find_files() end
      ),
      button(
        "<leader>b",
        "File Browser",
        function() require("telescope").extensions.file_browser.file_browser() end
      ),
      button(
        "<leader>l",
        "Live Grep",
        function() require("telescope.builtin").live_grep() end
      ),
      button(
        "<leader>gg",
        "Git status",
        function() require("telescope.builtin").git_status() end
      ),
      button(":Lazy", "Plugins", "Lazy"),
      button(":Mason", "Package Manager", "Mason"),
    },
    opts = {
      spacing = 0,
    },
  }
end

function footer()
  local ok, lazy = pcall(require, "lazy")
  if not ok then return {} end
  local stats = lazy.stats()
  return {
    type = "text",
    val = {
      "Loaded " .. stats.count .. " plugins in " .. (math.floor(
        stats.startuptime * 100 + 0.5
      ) / 100) .. "ms",
    },
    opts = {
      position = "center",
      hl = "Comment",
    },
  }
end

local nvim_version
function M.config()
  local ok, alpha = pcall(require, "alpha")
  if not ok then return end
  alpha.setup({
    layout = {
      { type = "padding", val = 2 },
      header(),
      { type = "padding", val = 1 },
      {
        type = "text",
        val = {
          nvim_version(),
        },
        opts = {
          position = "center",
          hl = "Number",
        },
      },
      { type = "padding", val = 1 },
      buttons(),
      { type = "padding", val = 2 },
      footer(),
    },
  })
  -- NOTE: need to manually call alpha, as
  -- it is loaded after the vim enter event
  -- (it is loaded later so the plugins info is available)
  alpha.start(true, alpha.default_config)
end

function button(sc, txt, on_press)
  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 0,
    width = 44,
    align_shortcut = "right",
    hl_shortcut = "Comment",
    hl = "Normal",
  }

  return {
    type = "button",
    val = txt,
    on_press = function()
      if type(on_press) == "function" then
        on_press()
      elseif type(on_press) == "string" then
        vim.cmd(on_press)
      end
    end,
    opts = opts,
  }
end

function nvim_version()
  local version = vim.version()

  local s = version.major
  s = s .. "." .. version.minor
  s = s .. "." .. version.patch
  if version.prerelease then s = s .. " (prerelease)" end
  return s
end

return M