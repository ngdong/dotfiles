local M = {}

function M.setup()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        sync_install = false,
        ignore_install = { "" },
        autopairs = {
            enable = true,
        },
        highlight = {
            enable = true,
            disable = { "" },
            additional_vim_regex_highlighting = true,
        },
        indent = { enable = true, disable = { "yaml" } },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    }
end

return M
