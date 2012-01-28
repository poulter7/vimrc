" call pathogen#infect()
:filetype plugin on 


" let's copy paste some lines from documentation
fun! SetupVAM()
	let addons_base = expand('$HOME') . '/.vim/vim-addons'
	exec 'set runtimepath+='.addons_base.'/vim-addon-manager'

	if !isdirectory(addons_base)
	  exec '!p='.shellescape(addons_base).'; mkdir -p "$p" && cd "$p" && git clone git://github.com/MarcWeber/vim-addon-manager.git'
	endif

    call vam#ActivateAddons(['Solarized', 'Syntastic','The_NERD_tree', 'pyflakes%2441',  'endwise', 'surround', 'rails', 'cucumber.zip', 'bundler', 'supertab',  'vcscommand', 'vim-addon-scala', 'rvm'], {'auto_install' : 1})
    " 
endf
call SetupVAM()

au! BufWritePost .vimrc source %
au! BufWritePost .vimrc source %

autocmd BufNewFile,BufRead *.csv setf csv
autocmd BufNewFile,BufRead *.tcl setf tcl

"setup shortcuts
let mapleader = "\\"
map <Leader>n :NERDTreeToggle<CR>

"check syntax on load
let g:syntastic_check_on_open=1
"jump to error
let g:syntastic_auto_jump=1
"error window opens and closes
let g:syntastic_auto_loc_list=1


map <S-Enter> O<Esc>
map <CR> o<Esc>
      
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set t_Co=256
set nocompatible
set nu
set showmatch
syntax on
filetype indent on
filetype on
set autoindent
set ic
set hls
set lbr
syn on
set background=dark
colorscheme solarized
set ofu=syntaxcomplete#Complete

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
map - <C-W>-
map + <C-W>+

"nmap <silent> <A-Up> :wincmd k<CR>
"
"nmap <silent> <A-Down> :wincmd j<CR>
"nmap <silent> <A-Left> :wincmd h<CR>
"nmap <silent> <A-Right> :wincmd l<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>

set hlsearch!
nnoremap <F3> :set hlsearch!<CR>

let g:pep8_map='<leader>8'
syntax on
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py set tabstop=4
autocmd BufRead *.py set shiftwidth=4
autocmd BufRead *.py set smarttab
autocmd BufRead *.py set expandtab
autocmd BufRead *.py set softtabstop=4
autocmd BufRead *.py set autoindent

"In some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html

"set nocompatible
"filetype off
"call pathogen#helptags()
"call pathogen#runtime_append_all_bundles()

" General {
    " try to detect filetypes
    filetype on
    filetype plugin on 
    filetype indent on
    set tabstop=2
    set smarttab
    set shiftwidth=2
    set autoindent
    set expandtab


    "set how many lines of history vim has to remember
    set history=1000
    
    "Set wildmenu which allows for command line completion
    set wildmenu

    set shortmess=aOstT " shortens messages to avoid 
                        " 'press a key' prompt
    "English spell checker by typing :set spell and z= for suggestion
    ":set spell spelllang=en

    " Weirdly the backspace stops working on existing text without this
    set backspace=indent,eol,start

    "Timeout before accepting that this is only the first keycode (i.e. it is
    "<C-L> not <C-L><C-L>
    set timeoutlen=500

    " Tell vim to remember certain things when we exit
    "  '10 : marks will be remembered for up to 10 previously edited files
    "  "100 : will save up to 100 lines for each register
    "  :20 : up to 20 lines of command-line history will be remembered
    "  % : saves and restores the buffer list
    "  n... : where to save the viminfo files
    set viminfo='10,\"100,:20,%,n~/.viminfo
" }

" Vim UI {
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you 
                       " search phrase
    set lazyredraw " do not redraw while running macros
    set shortmess=aOstT " shortens messages to avoid 
                        " 'press a key' prompt
    set showmatch " show matching brackets

    "set background=dark
    syntax on
    set t_Co=256
    set showmatch
    set background=dark
    let g:solarized_termcolors=256
    let g:solarized_visibility="low"
    colorscheme solarized

    "Set up relative line numbering instead of absolute as its useful to perform
    "actions to multiple lines
    "Make <C-N><C-N> toggle between line numberings relative absolute and none
    noremap <silent> <C-N><C-N> :call ToggleNumbers()<CR>
    set rnu

    func! ToggleNumbers()
        if !exists('s:cur')
            let s:cur = 0
        else
            let s:cur = (s:cur + 1) % 3
        endif

        if s:cur == 0
            set nu 
        elseif &nu == 1
            set nornu nonu
        else
            set rnu 
        endif
    endfunc

    " Highlight searched terms
    set hlsearch
    " Clear the search term so (n and p no longer search again
    map <C-L><C-L> :let @/=""<CR>
    " Remove search highlighting with <C-L>
    nnoremap <C-L> :nohls<CR><C-L>

    "set ofu=syntaxcomplete#Complete
    set completeopt+=longest,menu,preview

    " Make the popups like IDES, from 
    " "http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
    "inoremap <expr> <TAB> pumvisible() ? '<TAB>' :
    "  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

    "inoremap <TAB> <M-,> pumvisible() ? '<TAB>' :
    "  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"}

"Plugin settings {
    "Syntastic
    set statusline+=%#warningmsg# "enable flags in status bar
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let g:syntastic_enable_signs=1 "enable signs in side bar
    let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]' "Add status line showing erros
    
    "TASK LIST
    " Toggle task list (type \td to see a list of TODO:'s etc"
    map <leader>td <Plug>TaskList
    " TagList Settings {
    let Tlist_Auto_Open=0 " let the tag list open automagically
    let Tlist_Compact_Format = 1 " show small menu
    let Tlist_Ctags_Cmd = 'ctags' " location of ctags
    let Tlist_Enable_Fold_Column = 0 " do show folding tree
    let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill 
                                    " yourself
    let Tlist_File_Fold_Auto_Close = 0 " fold closed other trees
    let Tlist_Sort_Type = "name" " order by 
    let Tlist_Use_Right_Window = 1 " split to the right side
                                " of the screen
    let Tlist_WinWidth = 40 " 40 cols wide, so i can (almost always read my
                                "   functions)
    
    "SUPERTAB
    " For code completion with a drop down menu
    let g:SuperTabDefaultCompletionType = "context"
    "let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
    "let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
    "let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
    "let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

    "PEP8
    " Type \8 to check that python syntax complies with standard requirements
    let g:pep8_map='<leader>8'
    
    "PYDICTION
    " Setup pydiction locationn
    " let g:pydiction_location = '~/.vim/bundle/pydiction/complete-dict' 
    
    "PROJECT
    " Add recently accessed projects menu (project plugin)
    set viminfo^=!
    
    "RAILS
    " Change which file opens after executing :Rails command
    let g:rails_default_file='config/database.yml'

    "NERDTREE
    " Setup nerd tree shortcut to see directory listings
    map <Leader>n :NERDTreeToggle<CR>  
    
    "FUZZY FINDER
    let mapleader = "\\"
    map <leader>F :FufFile<CR>
    map <leader>FT :FufTaggedFile<CR>
    map <leader>f :FufCoverageFile<CR> "Recusively find from current directory downward
    map <leader>s :FufTag<CR>
    
    "EXUBERANT TAGS
    " Remake ctags with F5
    map <silent> <F5>:!ctags -R --exclude=.svn --exclude=.git --exclude=log *<CR>
    "Set up tag toggle mapping
    nmap <leader>t :TlistToggle<CR>
    
    "RVM info
    set statusline+=%{rvm#statusline()} 

    "VCSCommand
    map <leader>zc :VCSCommit<CR>
" }

" Auto commands {
    " Ruby {
        " ruby standard 2 spaces, always
        au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2 
        au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2 
        "If its an erb file, give html and ruby snippets
        au BufNewFile,BufRead *.html.erb set filetype=eruby.html
        
        " Adding ruby completion??
        " Turn on language specific omnifuncs
        "au FileType ruby,eruby set omnifunc=rubycomplete#Complete
        "au FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
        "au FileType ruby,eruby let g:rubycomplete_rails = 1
        "au FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
        "au FileType ruby,eruby let g:rubycomplete_include_object = 1
        "au FileType ruby,eruby let g:rubycomplete_include_objectspace = 1
    " }
    
    " If you prefer the Omni-Completion tip window to close when a selection is
    " made, these lines close it on movement in insert mode or when leaving
    " insert mode
    au CursorMovedI * if pumvisible() == 0|pclose|endif
    au InsertLeave * if pumvisible() == 0|pclose|endif
    
    "
    " Java {
    "let words = :call :PingEclim
    "let eclimer = split()
    "echo eclimer
        " Set up java autocompletion
        "au FileType java set completefunc=javacomplete#CompleteParamsInfo
        "This line broke things with omni completion: :setlocal completefunc=javacomplete#CompleteParamsInfo
        "au FileType java set omnifunc=javacomplete#CompleteParamsInfo
        "autocmd Filetype java setlocal omnifunc=javacomplete#Complete 
        "au FileType java set omnifunc=javacomplete#Complete 
    " }
" }

" Mappings {
    "Set up map leader
    let mapleader = '\'
    
    " Command to run current script by typing ;e
    map ;p :w<CR>:exe ":!python " . getreg("%") . "" <CR>
    
    "Add a new line
    nmap <CR> O<ESC>j
    
    "Remap increment number from <C-A> (which is used in screen) to <C-I>
    nmap <C-I> <C-A>
    
    " Navigate Omnicomplete with jk
    inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
    inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

    "Set up remaps for markers as ' is easier to press. Normally ' goes to the
    "line of the marker, and ` goes to the column and line of the marker, here I
    "am swapping them because it is easier to press ' and I would usually want
    "the effect of `
    nnoremap ' `
    nnoremap ` '

    " ROT13 - fun
    map <leader>r ggVGg?
" }
