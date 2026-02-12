return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
    init = function()
      -- typst configuration goes here, e.g.
      vim.g.typst_syntax_highlight = 1
      vim.g.typst_pdf_viewer = "zathura"
    end,
  },
}
