function ColorMyPencils(color)
    color = color
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "nyoom-engineering/oxocarbon.nvim",

        config = function()
            ColorMyPencils("oxocarbon")
        end
    },
    {
        "Yagua/nebulous.nvim",

        config = function()
            require("nebulous").setup({
                variant = "night",
            })
            ColorMyPencils("nebulous")
        end
    },
}
