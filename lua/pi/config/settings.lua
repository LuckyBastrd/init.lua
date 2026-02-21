vim.g.dotfiles_path = os.getenv("HOME") .. "/personal/dev"

vim.g.lualine_short_modes = require("pi.utils.statusline").load()
