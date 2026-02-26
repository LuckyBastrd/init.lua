vim.g.dotfiles_path = os.getenv("DEV_ENV_HOME")

vim.g.lualine_short_modes = require("pi.utils.statusline").load()
