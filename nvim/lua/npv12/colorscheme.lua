local status_ok_catppuccin, catppuccin = pcall(require, "catppuccin")
if not status_ok_catppuccin then
    return
end

local status_ok_highlight, color_highlighter = pcall(require, "nvim-highlight-colors")
if not status_ok_highlight then
    return
end

color_highlighter.setup {
    enable_tailwind = true,
    render = 'foreground'
}

catppuccin.setup({
    flavour = "mocha", -- latte, frappe, macchiato, moch  a
    background = { -- :h background
        light = "latte",
        dark = "mocha"
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = {"italic"},
        conditionals = {"italic"},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {"bold"},
        properties = {},
        types = {},
        operators = {}
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = true
    }
})

local colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    return
end
