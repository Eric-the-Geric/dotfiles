local languages = {
  "bash",
  "c",
  "css",
  "html",
  "javascript",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "r",
  "regex",
  "rust",
  "vim",
  "vimdoc",
}

if vim.fn.has("nvim-0.12") == 0 then
  return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = languages,
        auto_install = true,
        highlight = { enable = true },
      })
    end,
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")
    local pending = {}
    local available = {}
    for _, lang in ipairs(treesitter.get_available()) do
      available[lang] = true
    end

    local function start(buf)
      local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
      if not lang or vim.treesitter.highlighter.active[buf] then
        return
      end

      if vim.treesitter.language.add(lang) then
        vim.treesitter.start(buf, lang)
      elseif available[lang] and not pending[lang] then
        pending[lang] = true
        treesitter.install({ lang }):await(function(err, installed)
          pending[lang] = nil
          if not err and installed and vim.api.nvim_buf_is_valid(buf) then
            start(buf)
          end
        end)
      end
    end

    vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
      callback = function(args)
        start(args.buf)
      end,
    })

    for _, lang in ipairs(languages) do
      pending[lang] = true
    end
    treesitter.install(languages):await(function(err, installed)
      for _, lang in ipairs(languages) do
        pending[lang] = nil
      end
      if not err and installed then
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            start(buf)
          end
        end
      end
    end)
  end,
}
