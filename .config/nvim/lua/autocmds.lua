local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  vim.api.nvim_create_augroup(name, { clear = true })
end

-- highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_on_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
autocmd("VimResized", {
  group = augroup("equalize_windows"),
  callback = function()
    local curtab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. curtab)
  end,
})

-- strip trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("strip_trailing_whitespace"),
  pattern = "*",
  callback = function()
    save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- reload buffer if it changed outside of neovim
autocmd({ "FocusGained", "CursorHold", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})
