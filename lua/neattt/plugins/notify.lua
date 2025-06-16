return {
    "rcarriga/nvim-notify",

    event = "VeryLazy",

    opts = {},

    config = function()
        require("notify").setup({
            render = "compact",
            stages = "fade",
            timeout = 2000,
        })

        vim.notify = require('notify')
    end
}
