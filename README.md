# My-NeoVim-Config

Neovim config with lazy.vim.

Plugins{
  - **catppuccin/nvim**: A highly customizable and configurable pastel colorscheme for Neovim, offering four distinct "flavors" and extensive integrations with other plugins.
  - **nvimtools/none-ls.nvim**: A Neovim plugin that integrates Language Server Protocol (LSP) features like diagnostics and code actions from non-LSP sources, simplifying their setup and usage.
  - **jay-babu/mason-null-ls.nvim**: A bridge plugin that streamlines the combined usage of `mason.nvim` and `null-ls.nvim`, providing convenience APIs and automatic installation/configuration of `null-ls` sources.
  - **mason-org/mason.nvim**: A portable package manager for external editor tooling in Neovim, providing a unified interface for installing and managing LSP servers, DAP servers, linters, and formatters.
  - **nvim-tree/nvim-web-devicons**: Provides Nerd Font icons (glyphs) for use by Neovim plugins, offering colored icons for various file types and requiring a patched Nerd Font.
  - **rachartier/tiny-inline-diagnostic.nvim**: A Neovim plugin designed to display inline diagnostic messages in a "prettier" and less intrusive way, rendering diagnostics as inline virtual text without visual disruption.
  - **neovim/nvim-lspconfig**: A Neovim plugin that provides a collection of configurations for the built-in Neovim Language Server Protocol (LSP) client, simplifying the setup and integration of various language servers.
  - **folke/snacks.nvim**: A collection of small Quality of Life (QoL) plugins designed to enhance the Neovim experience, offering various functionalities like animations, big file handling, buffer management, Git integration, and a distraction-free Zen mode.
  - **nvim-treesitter/nvim-treesitter-context**: A Neovim plugin that displays the current code context (e.g., enclosing functions, classes) by leveraging Tree-sitter, helping users understand their position within the code structure.
  - **lewis6991/gitsigns.nvim**: Provides fast Git integration for Neovim buffers, offering features like signs for added/removed/changed lines, hunk management, Git blame, and extensive customization.
  - **folke/todo-comments.nvim**: A Neovim plugin that helps developers highlight, list, and search for "todo" comments (e.g., `TODO`, `HACK`, `BUG`, `FIX`) within their codebase, with customizable highlighting and search options.
  - **nvim-lua/plenary.nvim**: A comprehensive Lua library for Neovim that provides essential functions for plugin development, including asynchronous programming, system process interaction, file operations, and path manipulation.
  - **nvim-treesitter/nvim-treesitter**: A configuration and abstraction layer for Tree-sitter within Neovim, offering features like accurate and fast syntax highlighting, indentation, and code folding, and automating parser management.
  - **stevearc/conform.nvim**: A lightweight yet powerful formatter plugin for Neovim that applies formatting changes by calculating minimal differences, preserving cursor position and other editor states, and supporting a wide array of formatters.
}

I have JetBrainsMono from NerdFonts
{https://www.nerdfonts.com/font-downloads}

Setup:

```
mkdir -p ~/.local/share/fonts/

Download the wanted fonts
Unzip

fc-cache -fv
```
