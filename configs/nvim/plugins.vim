" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" Auto-close plugin
Plug 'rstacruz/vim-closer'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins'}

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" Comment function
Plug 'preservim/nerdcommenter'

" Change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'tpope/vim-fugitive'
Plug 'APZelos/blamer.nvim'

" === Javascript Plugins === "
" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx', 'typescript'],
  \ 'do': 'make install'
\}

" === Syntax Highlighting === "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx'

" Syntax highlighting for nginx
Plug 'chr4/nginx.vim'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'

" Customized vim status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Editor config
Plug 'editorconfig/editorconfig-vim'

" A multi language graphical debugger for Vim
Plug 'puremourning/vimspector'

" View and search LSP symbols, tags in Vim/NeoVim
Plug 'liuchengxu/vista.vim'

" Preview markdown on browser
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Initialize plugin system
call plug#end()
