local M = {}

-- central paths
local base_path = vim.fn.stdpath("data") .. "/pi"
local cps_folder = base_path .. "/colorscheme_picker"
local sl_folder = base_path .. "/statusline"

-- ensure folders exist
vim.fn.mkdir(base_path, "p")
vim.fn.mkdir(cps_folder, "p")
vim.fn.mkdir(sl_folder, "p")

M.colorscheme_picker = cps_folder
M.statusline = sl_folder

return M
