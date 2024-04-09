-- vim.cmd.language("en_US.UTF-8")

-- vim.g.autoformat = false

local opt = vim.opt

opt.completeopt = { "menu", "menuone", "noselect" }

-- cause neovim to usse the system clipboard for all yanking operations
opt.clipboard = "unnamedplus"

-- true color support
opt.termguicolors = true

-- show a column at 80 characters as a guide for long lines
opt.colorcolumn = "80"

-- confirm to save changes before exiting modified buffer
opt.confirm = true

-- hightlight the current line
-- opt.cursorline = true

-- use ripgrep in smart-case mode for grepping
opt.grepprg = "rg --vimgrep --smart-case"

-- show some invisible characters
opt.list = true
opt.listchars = {
  tab = "  ", nbsp = "␣", extends = "»", precedes = "«", trail = "•",
}

-- always draw sign column. prevents buffer moving when adding/deleting sign
opt.signcolumn = "yes"

-- enable relative numbering
opt.relativenumber = true
-- and show the absolute line number for the current line
opt.number = true

-- when scrolling, always keep the cursor N lines from the edges
opt.scrolloff = 8

-- by default ...
opt.expandtab = true -- expand tabs to spaces
opt.textwidth = 0    -- don't auto-wrap text
opt.tabstop = 2      -- use two space indents by default
opt.shiftwidth = 2
opt.softtabstop = 2

-- auto formatting options
--   t - auto-wrap text by respecting textwidth
--   c - auto-wrap comments by respecting textwidth
--   r - auto-insert comment leading after <CR> in insert mode
--   o - auto-insert comment leading after o/O in normal mode
opt.formatoptions = "tcro"

-- don't show mode since I have a lualine
opt.showmode = false

-- infinite undo
opt.undofile = true

-- save swap file and trigger CursorHold
opt.updatetime = 100

-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
opt.wildmode = "list:longest"

-- never wrap lines if line breaks are not there
opt.wrap = false

-- allow cursor to move where there is no text in visual block mode
opt.virtualedit = "block"
