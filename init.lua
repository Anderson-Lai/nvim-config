-- Initialize plugins using vim-plug
vim.cmd([[
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'

" Nvim-Tree plugin and dependencies
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons

" Gruvbox theme
Plug 'morhetz/gruvbox'

call plug#end()
]])

-- Set encoding
vim.opt.encoding = "utf-8"

-- Disable backups
vim.opt.backup = false
vim.opt.writebackup = false

-- Disable netrw (default file explorer) to avoid conflicts with Nvim-Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Nvim-Tree setup
require("nvim-tree").setup()

-- Nvim-ts-autotag and treesitter setup
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "html", "javascript", "typescript", "c", "cpp" },  -- Add other languages as needed
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "c", "cpp" },
  },
}

-- Set colorscheme
vim.cmd("colorscheme gruvbox")
vim.opt.termguicolors = false

-- Enable syntax highlighting
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- Enable relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Font size (adjust as necessary)
vim.opt.guifont = "FiraCode:h14"

-- Clipboard setup
vim.opt.clipboard:append("unnamedplus")

-- Updatetime for faster UI response
vim.opt.updatetime = 300

-- Always show sign column
vim.opt.signcolumn = "yes"

-- Key mappings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- CMake command mapping
keymap("n", "<leader>cmake", ":term bash -c 'mkdir -p build && cd build && cmake .. && mv compile_commands.json ../' :exit<CR>", opts)

-- Clear highlight mapping
keymap("n", "<leader>clearhl", ":nohlsearch<CR>", opts)

-- Coc diagnostics mapping
keymap("n", "<leader>intelli", ":CocDiagnostics<CR>", opts)

-- NvimTree mappings
keymap("n", "<leader>toggle", ":NvimTreeToggle<CR>", opts)
keymap("n", "t", ":NvimTreeFocus<CR>", opts)

-- Tab and autocomplete mappings for CoC
vim.cmd([[
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr> <tab> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<TAB>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]])

-- Check for backspace function
vim.cmd([[
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]])

-- Use <c-space> to trigger completion
keymap("i", "<c-space>", "coc#refresh()", { noremap = true, expr = true })

-- Diagnostics navigation mappings
keymap("n", "[g", "<Plug>(coc-diagnostic-prev)", opts)
keymap("n", "]g", "<Plug>(coc-diagnostic-next)", opts)

-- GoTo code navigation mappings
keymap("n", "gd", "<Plug>(coc-definition)", opts)
keymap("n", "gy", "<Plug>(coc-type-definition)", opts)
keymap("n", "gi", "<Plug>(coc-implementation)", opts)
keymap("n", "gr", "<Plug>(coc-references)", opts)

-- Show documentation on K press
vim.cmd([[
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
]])

-- Highlight the symbol and its references on cursor hold
vim.cmd("autocmd CursorHold * silent call CocActionAsync('highlight')")

-- Symbol renaming
keymap("n", "<leader>rn", "<Plug>(coc-rename)", opts)

-- Formatting selected code
keymap("x", "<leader>f", "<Plug>(coc-format-selected)", opts)
keymap("n", "<leader>f", "<Plug>(coc-format-selected)", opts)

-- Auto commands for file types
vim.cmd([[
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
]])

-- Code actions mappings
keymap("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keymap("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

keymap("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
keymap("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
keymap("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Code refactor mappings
keymap("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", opts)
keymap("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", opts)
keymap("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", opts)

-- Code lens action mapping
keymap("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

-- Function and class text objects
vim.cmd([[
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
]])

-- Scroll float windows/popups mappings
vim.cmd([[
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
]])

-- CTRL-S for selections
vim.cmd([[
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
]])

-- Add custom commands for formatting, folding, and organizing imports
vim.cmd([[
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
]])

-- Native statusline integration
vim.opt.statusline = "%{coc#status()}%{get(b:,'coc_current_function','')}"

-- Mappings for CocList
keymap("n", "<space>a", ":<C-u>CocList diagnostics<CR>", opts)
keymap("n", "<space>e", ":<C-u>CocList extensions<CR>", opts)
keymap("n", "<space>c", ":<C-u>CocList commands<CR>", opts)
keymap("n", "<space>o", ":<C-u>CocList outline<CR>", opts)
keymap("n", "<space>s", ":<C-u>CocList -I symbols<CR>", opts)
keymap("n", "<space>j", ":<C-u>CocNext<CR>", opts)
keymap("n", "<space>k", ":<C-u>CocPrev<CR>", opts)
keymap("n", "<space>p", ":<C-u>CocListResume<CR>", opts)
