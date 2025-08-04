-----------------
-- N E O V I M --
-- main config --
-----------------
require("initRocks");
require("utilities");

--------------------
-- FISH SHELL FIX --
--------------------

-- when launched in fish, neovim throws "E71: Cannot expand Wildcards"
-- the following three lines fix this, because they "replace" neovim's default shell from fish to a POSIX shell (zsh)
if vim.fs.basename(vim.o.shell) == 'fish' then
    vim.opt.shell = '/bin/zsh'
end

--------------------
-- KEYBIND CONFIG --
--------------------

-- set space as leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- load keymaps
require("keybinds");

----------------------
-- COLORSCHEME INIT --
----------------------

require("colours");
---------------------------
-- VIMSCRIPT FILES START --
---------------------------

vim.cmd('source ~/.config/nvim/autostart.vim');

-------------------
-- P L U G I N S --
-------------------

---------
-- LSP --
---------

-- show context (function definition, ...)
require'treesitter-context'.setup{}
-- import local LSP configuration
require("lsp");

-- import local formatting configuration
require("conform").setup({
  formatters_by_ft = {
    rust = {"rustfmt"},
    c    = {"clang-format"},
    cpp  = {"clang-format"}
  }
})
-- 2-wide tabs in rust
require("conform").formatters.rustfmt = {
  prepend_args = { "--config", "tab_spaces=2" },
}

-- format on write
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })


-- trouble - list all mistakes
require("trouble").setup {}
require'barbar'.setup {
  auto_hide = 1,
}

-- and todo-comments - nice formatting for comments like 
-- INFO: this is an example
require("todo-comments").setup()

-- nvim-tree: navigation tree
require("nvim-tree").setup();

--------------
-- RUN CODE --
--------------
local prjroot=
require('code_runner').setup {
  filetype = {
    rust = {"cd $dir &&", "cargo run"},	
    c    = {"cd "..find_project_root().." &&", "make run"},
    cpp  = {"cd "..find_project_root().." &&", "make run"},
    make = {"cd "..find_project_root().." &&", "make run"},
    asm  = {"cd $dir &&","make run"},
    python = "python3 -u",
    java = { "cd $dir &&", "javac $fileName &&", "java $fileNameWithoutExt" },
    lua = "lua",
  }	
}
--------------
-- MORE LSP --
--------------

-- lspsage - lsp utils
require("lspsaga").setup({
  lightbulb = {
    virtual_text = false
  }
});


------------------
-- MORE PLUGINS --
------------------

-- local config: lualine panel
require("statusline");

-- show colors and color picker
local ccc = require("ccc")
local mapping = ccc.mapping

ccc.setup({
  -- Your preferred settings
  -- Example: enable highlighter
  highlighter = {
    auto_enable = true,
    lsp = true,
  },
})
-- drawing ascii mode
require('plugins/venn');

-- some small features
local snacks = require("snacks")

snacks.setup({
  opts={
    dim={},
  }
})
-- snacks.dim.enable();

-- which-key
local wk = require("which-key")
wk.setup({
  win = {
    border = "single",  -- Set window border to single
  },
})

-- auto pairs (like ([{""}]))
require('nvim-autopairs').setup({})
-- mini.nvim components
-- require('mini.animate').setup()		              -- animation
require('mini.starter').setup({header=get_header()})  -- start screen
require('mini.comment').setup()                       -- quickly comment using gc in normal/visual mode 
