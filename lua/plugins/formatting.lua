return {
  "stevearc/conform.nvim",
  --  lazy = false,

  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "yapf" },
      java = { "google-java-format" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      cs = { "csharpier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      bash = { "shfmt" },
      go = { "goimports" },
      rust = { "rustfmt" },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
