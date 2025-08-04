local hl_normal = vim.api.nvim_get_hl(0, {name="Normal"})
local normal_bg = hl_normal.bg and string.format("#%06x", hl_normal.bg) or "NONE"
local normal_fg = hl_normal.fg and string.format("#%06x", hl_normal.fg) or "NONE"


local theme = require("lualine.themes.everforest")-- require("lualine.themes.auto")
  local bg = normal_bg
  -- local fg = normal_fg
   theme.normal.c.bg = bg
   theme.insert.c.bg = bg
   theme.visual.c.bg = bg
   theme.replace.c.bg = bg
   theme.command.c.bg = bg
   theme.inactive.c.bg = bg

  require("lualine").setup({
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {"mode", separator = { left = '', right='' } }
      },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
       "filetype",
      },
      lualine_y = {"location"},
      lualine_z = {
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })
