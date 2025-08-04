------------------
-- LOAD COLOURS --
------------------

-- extending everforest.nvim

-- base colourscheme - everforest
local everforest = require("everforest");

dofile(vim.fn.stdpath("config") .. "/../colourscheme/colours.lua")

everforest.setup({
  background="hard",
  transparency_background_level = 0,
  italics = true,
  disable_italic_comments = false,
  diagnostic_line_highlight = true,
  diagnostic_text_highlight = true,
  colours_override = function(palette)
    palette.bg_dim    = colourscheme["bg_dark"]
    palette.bg0       = colourscheme["bg_color"]
    palette.bg1       = colourscheme["bg_lighter_dark"]
    palette.bg2       = "#2A241E"
    palette.bg3       = "#241F19"
    palette.bg4       = "#4d3d2c"
    palette.bg5       = "#665844"
    palette.bg_visual = colourscheme["bg_highlight"]
    palette.bg_red    = "#512D2C"
    palette.bg_green  = "#117449"
    palette.bg_blue   = "#2E3F3D"
    palette.bg_yellow = "#54411F"


    palette.fg0       = "#d2c0a4"
    palette.grey0     = "#7a8478"
    palette.grey1     = "#859289"
    palette.grey2     = "#9da9a0"
    palette.red       = colourscheme["red"]
    palette.aqua      = colourscheme["green"]
    palette.green     = colourscheme["cyan"]
    palette.orange    = colourscheme["yellow"]
    palette.yellow    = "#cea33f"
    palette.purple    = "#CE665B"
    palette.blue      = "#4db2d1"
    
  end,
});
everforest.load();
