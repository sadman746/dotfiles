-------------------------------------------------
-- BASE
-------------------------------------------------
vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true

-- Formattazione automatica con prettier
vim.opt.formatoptions = "jcroqlnt"

-------------------------------------------------
-- KEYMAP BASE
-------------------------------------------------
local map = vim.keymap.set

map("n", "<C-s>", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>w", ":w<CR>")

-- split navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Buffer navigation
map("n", "gt", ":bnext<CR>")
map("n", "gT", ":bprevious<CR>")
map("n", "<leader>bd", ":bdelete<CR>")
map("n", "<leader>bn", ":bnext<CR>")
map("n", "<leader>bp", ":bprevious<CR>")

-------------------------------------------------
-- LAZY.NVIM (plugin manager)
-------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-------------------------------------------------
-- PLUGINS
-------------------------------------------------
require("lazy").setup({

  -- THEME
  { "folke/tokyonight.nvim", priority = 1000 },

  -- FILE EXPLORER
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },

  -- STATUSLINE
  { "nvim-lualine/lualine.nvim" },

  -- FUZZY FINDER
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- GIT
  { "lewis6991/gitsigns.nvim" },

  -- AUTOCOMPLETE
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  
  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Treesitter
  { 
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- ============================================
  -- NUOVI PLUGIN - UI
  -- ============================================
  
  -- Which-key: mostra keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
    },
  },

  -- Indent blankline: linee verticali indentazione
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Bufferline: tab per buffer
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Trouble: lista errori
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  -- Todo-comments: evidenzia TODO/FIXME
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
  },

  -- ============================================
  -- NUOVI PLUGIN - NAVIGAZIONE
  -- ============================================
  
  -- Harpoon: file favorites
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Flash: salto rapido
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- ============================================
  -- NUOVI PLUGIN - EDITING
  -- ============================================
  
  -- Autopairs: chiude automaticamente parentesi
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Comment: commenta/decommenta
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ============================================
  -- NUOVI PLUGIN - FORMATTING
  -- ============================================
  
  -- Conform: formattazione (Prettier)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
  },

  -- Emmet: espansioni HTML veloci
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },

})

-------------------------------------------------
-- THEME
-------------------------------------------------
vim.cmd.colorscheme("tokyonight-night")

-- background trasparente
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

-------------------------------------------------
-- NVIM TREE
-------------------------------------------------
require("nvim-tree").setup({
  view = { width = 30 },
})
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-------------------------------------------------
-- LUALINE
-------------------------------------------------
require("lualine").setup({
  options = {
    theme = "tokyonight",
    section_separators = "",
    component_separators = "",
    globalstatus = true,
  },
})

-------------------------------------------------
-- TELESCOPE
-------------------------------------------------
local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files)
map("n", "<leader>fg", telescope.live_grep)
map("n", "<leader>fb", telescope.buffers)

-------------------------------------------------
-- GITSIGNS
-------------------------------------------------
require("gitsigns").setup()

-------------------------------------------------
-- AUTOCOMPLETE
-------------------------------------------------
local cmp = require("cmp")

-- Integrazione con nvim-autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-------------------------------------------------
-- WHICH-KEY (mostra keybindings)
-------------------------------------------------
local wk = require("which-key")
wk.add({
  { "<leader>e", desc = "Toggle Explorer" },
  { "<leader>f", group = "Find" },
  { "<leader>ff", desc = "Find Files" },
  { "<leader>fg", desc = "Live Grep" },
  { "<leader>fb", desc = "Find Buffers" },
  { "<leader>h", group = "Harpoon" },
  { "<leader>w", desc = "Save" },
  { "<leader>q", desc = "Quit" },
  { "<leader>x", group = "Trouble" },
  { "<leader>xx", desc = "Toggle Diagnostics" },
  { "<leader>xd", desc = "Document Diagnostics" },
  { "<leader>xw", desc = "Workspace Diagnostics" },
  { "<leader>b", group = "Buffer" },
  { "<leader>bd", desc = "Close Buffer" },
  { "<leader>bn", desc = "Next Buffer" },
  { "<leader>bp", desc = "Previous Buffer" },
  { "<leader>n", group = "NPM" },
  { "<leader>ni", desc = "NPM Install" },
  { "<leader>nr", desc = "NPM Run" },
  { "<leader>nd", desc = "NPM Dev" },
  { "<leader>nb", desc = "NPM Build" },
  { "<leader>ft", desc = "Find TODOs" },
})

-------------------------------------------------
-- HARPOON (file favorites)
-------------------------------------------------
local harpoon = require("harpoon")
harpoon:setup()

map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add" })
map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

-- Navigazione rapida ai file 1-4
map("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
map("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
map("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
map("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })

-------------------------------------------------
-- FLASH (salto rapido)
-------------------------------------------------
local flash = require("flash")
flash.setup()

-- Salto in avanti
map({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash Jump" })
-- Salto all'indietro
map({ "n", "x", "o" }, "S", function() flash.jump({ search = { forward = false } }) end, { desc = "Flash Jump Backward" })

-------------------------------------------------
-- NVIM-AUTOPAIRS (chiudi parentesi)
-------------------------------------------------
require("nvim-autopairs").setup({
  check_ts = true,  -- Usa treesitter per controllare
})

-------------------------------------------------
-- COMMENT (commenta/decommenta)
-------------------------------------------------
require("Comment").setup()

-- gcc = commenta riga
-- gc = commenta selezione (visual mode)
-- gcap = commenta paragrafo

-------------------------------------------------
-- TROUBLE (lista errori)
-------------------------------------------------
require("trouble").setup()

map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace Diagnostics" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix List" })

-------------------------------------------------
-- BUFFERLINE (tab minimalisti)
-------------------------------------------------
require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "thin",           -- Linee sottili invece di slant
    always_show_bufferline = true,
    show_buffer_close_icons = false,    -- Rimuove icona X
    show_close_icon = false,            -- Rimuove icona chiusura globale
    show_tab_indicators = false,        -- Rimuove indicatori
    enforce_regular_tabs = false,       -- Non forza larghezza uguale
    tab_size = 18,                      -- Tabs compatti
    max_name_length = 20,               -- Nome max 20 char
    truncate_names = true,              -- Tronca nomi lunghi
    diagnostics = false,                -- No indicatori diagnostica sui tab
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        highlight = "Directory",
        separator = true,
      },
    },
    name_formatter = function(buf)
      -- Mostra solo il nome file, rimuove percorso
      return vim.fn.fnamemodify(buf.name, ":t")
    end,
  },
})

-------------------------------------------------
-- TODO-COMMENTS (evidenzia TODO)
-------------------------------------------------
require("todo-comments").setup()

map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find TODOs" })

-------------------------------------------------
-- CONFORM (formatting con Prettier)
-------------------------------------------------
require("conform").setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

-- Formatta manualmente
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Code" })

-------------------------------------------------
-- MASON + LSP
-------------------------------------------------
require("mason").setup()

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configurazione LSP servers
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

vim.lsp.config("html", {
  capabilities = capabilities,
})

vim.lsp.config("cssls", {
  capabilities = capabilities,
})

vim.lsp.config("tailwindcss", {
  capabilities = capabilities,
})

vim.lsp.config("eslint", {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

vim.lsp.config("jsonls", {
  capabilities = capabilities,
})

vim.lsp.config("emmet_ls", {
  capabilities = capabilities,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})

-- Abilita tutti i server
vim.lsp.enable({ "ts_ls", "html", "cssls", "tailwindcss", "eslint", "jsonls", "emmet_ls", "lua_ls" })

-- Keybindings LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

require("mason-lspconfig").setup({
  ensure_installed = { 
    "ts_ls", 
    "lua_ls", 
    "html", 
    "cssls", 
    "tailwindcss", 
    "eslint", 
    "jsonls",
    "emmet_ls"
  }
})

-------------------------------------------------
-- KEYBINDINGS NPM
-------------------------------------------------
map("n", "<leader>ni", function()
  vim.cmd("term npm install")
end, { desc = "NPM Install" })

map("n", "<leader>nr", function()
  vim.cmd("term npm run")
end, { desc = "NPM Run" })

map("n", "<leader>nd", function()
  vim.cmd("term npm run dev")
end, { desc = "NPM Dev" })

map("n", "<leader>nb", function()
  vim.cmd("term npm run build")
end, { desc = "NPM Build" })

-------------------------------------------------
-- TREESITTER
-------------------------------------------------
require("nvim-treesitter.config").setup({
  ensure_installed = { 
    "lua", 
    "javascript", 
    "typescript", 
    "tsx",
    "html",
    "css",
    "json",
    "yaml",
    "markdown",
    "bash"
  },
  highlight = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
})
