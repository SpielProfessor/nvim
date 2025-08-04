-- L S P   C O N F I G U R A T I O N --
local lspconfig = require("lspconfig")

-- setup blink.cmp
require('cmp_colors')
local blink = require("blink.cmp")
blink.setup({
  keymap = {
    preset = "none",
    ['<S-Tab>']   = {'select_prev', 'fallback'},
    ['<Tab>']     = {'select_next', 'fallback'},
    ['<C-s>'] = {function(cmp) cmp.show({providers = {'snippets'}}) end},
    ['<Enter>']   = {'select_and_accept', 'fallback'},
    ['<C-h>']     = {'show_signature', 'show_documentation'}
  },
  appearance = {
    kind_icons = {
      Text          = '󰉿 ',
      Method        = '󰊕 ',
      Function      = '󰊕 ',
      Constructor   = '󰒓 ',

      Field         = '󰜢 ',
      Variable      = '󰆦 ',
      Property      = '󰖷 ',

      Class         = '󱡠 ',
      Interface     = '󱡠 ',
      Struct        = '󱡠 ',
      Module        = '󰅩 ',

      Unit          = '󰪚 ',
      Value         = '󰦨 ',
      Enum          = '󰦨 ',
      EnumMember    = '󰦨 ',

      Keyword       = '󰻾 ',
      Constant      = '󰏿 ',

      Snippet       = '󱄽 ',
      Color         = '󰏘 ',
      File          = '󰈔 ',
      Reference     = '󰬲 ',
      Folder        = '󰉋 ',
      Event         = '󱐋 ',
      Operator      = '󰪚 ',
      TypeParameter = '󰬛 ',
    },
  },
  completion = { 
    documentation = { auto_show = true }, 
    ghost_text    = { enabled = true },
    menu          = {
      draw = {
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } }
      }
    }
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'nerdfont', 'calc' },
    providers = {
      nerdfont = {
        module = "blink-nerdfont",
        name = "Nerd Fonts",
        score_offset = 15, -- Tune by preference
        opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
      },
      calc = {
        name   = 'calc',
        module = 'blink.compat.source',
      },
    }
  },
  signature = {
    enabled = true,
    trigger = {
      show_on_keyword = true,
      -- show_on_insert  = true
    }
  },
  fuzzy = {
    implementation = "lua"
  }

});

local capabilities = blink.get_lsp_capabilities();

-- Setup nvim-cmp
-- local cmp = require("cmp")
-- local lspkind = require('lspkind')
-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
-- 
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       --vim.fn["luasnip#anonymous"](args.body) -- Use vsnip or change to luasnip, etc.
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   mapping = {
--     ["<Tab>"] = cmp.mapping.select_next_item(),
--     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
--     ["<CR>"] = cmp.mapping.confirm({ select = true }),
--     ["<C-Space>"] = cmp.mapping.complete(),
--   },
--   sources = cmp.config.sources({
--     { name = "nvim_lsp" },
--     { name = "buffer" },
--     { name = "path" },
--     { name = "calc" },
--     { name = 'nerdfont' },
--     { name = 'buffer' },
--   }),
--
--   window = {
--     completion = {
--       winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
--       col_offset = -3,
--       side_padding = 0,
--     },
--   },
--   formatting = {
--     fields = { "kind", "abbr", "menu" },
--     format = function(entry, vim_item)
--       local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
--       local strings = vim.split(kind.kind, "%s", { trimempty = true })
--       kind.kind = " " .. (strings[1] or "") .. " "
--       kind.menu = "    (" .. (strings[2] or "") .. ")"
--
--       return kind
--     end,
--   },
-- })
--
-- local capabilities = cmp_nvim_lsp.default_capabilities()

-- rust analyzer
lspconfig.rust_analyzer.setup({capabilities=capabilities}) 
-- C
lspconfig.clangd.setup(
  {
    capabilities=capabilities, 
    cmd = {
      "clangd",
      "--clang-tidy",                      -- Enable clang-tidy
      "--fallback-style=llvm",             -- Optional: style fallback
      "--header-insertion=never",          -- Optional: avoid annoying header suggestions
    }
  }
)

-- indent blankline
require("ibl").setup()
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "always", -- show error source in popup
    border = "rounded",
  },
})

-- LSP signature help
cfg = {
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number
 
  bind = true, -- This is mandatory, otherwise border config won't get registered.
               -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                 -- set to 0 if you DO NOT want any API comments be shown
                 -- This setting only take effect in insert mode, it does not affect signature help in normal
                 -- mode, 10 by default
 
  max_height = 12, -- max height of signature floating_window, include borders
  max_width = function()
    return vim.api.nvim_win_get_width(0) * 0.8
  end, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                  -- the value need >= 40
                  -- if max_width is function, it will be called
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
 
  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap
 
  floating_window_off_x = 1, -- adjust float windows x position.
                             -- can be either a number or function
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                              -- can be either number or function, see examples
 
  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  -- or, provide a table with 3 icons
  -- hint_prefix = {
  --     above = "↙ ",  -- when the hint is on the line above the current line
  --     current = "← ",  -- when the hint is on the same line
  --     below = "↖ "  -- when the hint is on the line below the current line
  -- }
  hint_scheme = "String",
  hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
  -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
  -- return 'right_align' to display hint right aligned in the current line
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
  },
 
  always_trigger = true, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
 
  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
 
  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
 
  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
     -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
     -- may not popup when typing depends on floating_window setting
 
  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_signature_window_key = nil, -- move the floating window, e.g. {'<M-k>', '<M-j>'} to move up and down, or
    -- table of 4 keymaps, e.g. {'<M-k>', '<M-j>', '<M-h>', '<M-l>'} to move up, down, left, right
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating window
  -- e.g. move_cursor_key = '<M-p>',
  -- once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down
  keymaps = {}  -- relate to move_cursor_key; the keymaps inside floating window with arguments of bufnr
  -- e.g. keymaps = function(bufnr) vim.keymap.set(...) end
  -- it can be function that set keymaps
  -- e.g. keymaps = { { 'j', '<C-o>j' }, } this map j to <C-o>j in floating window
  -- <M-d> and <M-u> are default keymaps to move cursor up and down
}

-- recommended:
require'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
