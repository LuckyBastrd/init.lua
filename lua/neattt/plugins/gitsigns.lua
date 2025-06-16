return {
    {
        "lewis6991/gitsigns.nvim",

        ft = "gitcommit",

        config = function ()
            require("gitsigns").setup()
        end
    }
}
