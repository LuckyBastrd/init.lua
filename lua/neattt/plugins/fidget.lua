return {
    "j-hui/fidget.nvim",

    tag = "v1.6.1",

    config = function()
        require("fidget").setup({
            notification = {
                -- Redirect notifications to nvim-notify
                redirect = function(msg, level, opts)
                -- Check if the message has the on_open option set (optional)
                if opts and opts.on_open then
                    return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
                end
            end,
            },
        })
    end,
}

