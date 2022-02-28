syntax on
set number
set spell
set wrap
set showcmd
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" markdown config
autocmd Filetype markdown inoremap <buffer> .f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> .w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> .n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> .b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> .s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> .i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> .d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> .c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> .q -  
autocmd Filetype markdown inoremap <buffer> .p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> .a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> .1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> .2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> .3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> .4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> .l --------<Enter>

noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		set splitbelow
		:sp
		:res -5
		term gcc -ansi -Wall % -o %< && time ./%<
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'cs'
		set splitbelow
		silent! exec "!mcs %"
		:sp
		:res -5
		:term mono %<.exe
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

call plug#begin('~/.vim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
" 
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

Plug 'vim-airline/vim-airline'

Plug 'connorholyday/vim-snazzy'

Plug 'dhruvasagar/vim-table-mode'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Initialize plugin system
call plug#end()


" NERDTree config
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


