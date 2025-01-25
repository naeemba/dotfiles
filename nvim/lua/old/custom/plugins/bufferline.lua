local status, bufferline = pcall(require, "bufferline")
if (not status) then return end

local mocha = require("catppuccin.palettes").get_palette "mocha"
bufferline.setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
        custom = {
            all = {
                fill = { bg = "#000000" },
            },
            mocha = {
                background = { fg = mocha.text },
            },
            latte = {
                background = { fg = "#000000" },
            },
        },
    },
    options = {
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = 'nvim_lsp'
    }
}
