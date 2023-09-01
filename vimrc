" execute pathogen#infect()
" execute pathogen#helptags()
filetype indent plugin on
runtime macros/matchit.vim
set nocompatible
set noshowmode
" set cmdheight=2
set shortmess+=c
set updatetime=300

" Colors and styles
set t_Co=256
set termguicolors
syntax on
syntax sync minlines=256
set background=dark
color falcon
set guifont=Dank\ Mono:h16
set linespace=4
set winwidth=90
set relativenumber
set number
" let g:airline_theme='gruvbox'
" let g:airline_powerline_fonts = 1
set laststatus=2
autocmd BufEnter * if &filetype == "" | setlocal ft=markdown | endif
autocmd FileType notes setlocal spell | let b:coc_suggest_disable=1
autocmd BufReadPost *.conf* set ft=nginx

" vim-active-numbers

let g:actnum_exclude =
      \ [ 'unite', 'tagbar', 'startify', 'undotree', 'gundo', 'vimshell', 'w3m', 'nerdtree']

" Pear Tree

let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_backspace   = 1
let g:pear_tree_smart_closers     = 1
let g:pear_tree_smart_openers     = 1

let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '`': {'closer': '`'}
            \ }

" Persistent Undo
set undofile
set undodir=/Users/eric/.vim/undo/

set rtp+=/opt/homebrew/opt/fzf
" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
let g:fzf_tags_command = './.git/hooks/ctags'
" Lightline "
" \ 'component_type': {
" \    'linter_warnings': 'warning',
" \    'linter_errors': 'error',
" \    'linter_ok': 'ok',
" \ },
"
let g:falcon_lightline = 1
let g:lightline = {
      \ 'colorscheme': 'falcon',
      \ 'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'project', 'filename' ],
      \               [ 'ctrlpmark' ] ],
      \     'right': [ ['cocstatus', 'lineinfo'],
      \                [ 'currentfunction', 'filetype' ] ]
      \   },
      \   'inactive': {
      \     'left': [ [ 'filename' ] ],
      \     'right': [ [ 'lineinfo' ],
      \                [ 'filetype' ] ]
      \   },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'component_function': {
      \   'ctrlpmark': 'CtrlPMark',
      \   'project': 'LightlineProject',
      \   'lineinfo': 'LightlineLineinfo',
      \   'filename': 'LightlineFilename',
      \   'fugitive': 'LightlineFugitive',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \}
" some alternate sep glyph ideas
"  'left': '', 'right': ''
"  'left': '', 'right': ''
"  'left': '', 'right': ''
"  'left': '', 'right': ''

let g:lightline.mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'V-L',
      \ "\<C-v>": 'V-B',
      \ 'c' : 'C',
      \ 's' : 'S',
      \ 'S' : 'S-L',
      \ "\<C-s>": 'S-B',
      \ 't': 'T',
      \ }

function! LightlineLineinfo()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' : printf('%d:%-2d', line('.'), col('.'))
endfunction

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction

" function! LightlineLinterWarnings() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
" endfunction

" function! LightlineLinterErrors() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
" endfunction

" function! LightlineLinterOk() abort
"   let l:counts = ale#statusline#Count(bufnr(''))
"   let l:all_errors = l:counts.error + l:counts.style_error
"   let l:all_non_errors = l:counts.total - l:all_errors
"   let l:match_type=0
"   for pkey in keys(g:ale_linters)
"     if pkey == &ft
"       let l:match_type = 1
"     endif
"   endfor
"   if l:match_type == 0
"     return ''
"   endif
"   return l:counts.total == 0 ? '✓' : ''
" endfunction

" " update status after ale finishes linting
" autocmd User ALELint call lightline#update()

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineProject()
  return fnamemodify(getcwd(), ":t")
endfunction


function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ' '  " edit here for cool mark
      let branch = fugitive#head()
      let project = LightlineProject() . '/'
      return (winwidth(0) > 70 && branch !=# '') ? mark.project.branch : mark.project
      " return winwidth(0) > 70 && branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('index.js' == fname ? expand('%:p:h:t') . '/' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  " return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  " return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction


" JSX "
let g:jsx_ext_required = 0
hi link xmlEndTag xmlTag
autocmd FileType javascriptreact UltiSnipsAddFiletypes html
let g:vim_jsx_pretty_colorful_config = 1

" Ruby "
" let ruby_fold = 1
" let ruby_foldable_groups = 'def'

set visualbell
set autoindent
set guioptions-=e
set guioptions-=r
set nocursorline
set hidden
set splitbelow
set splitright
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set nobackup
set nowritebackup
set noswapfile
set autoread
set clipboard=unnamed
set exrc
set secure
set gdefault
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <Leader><Leader> :nohlsearch<CR>

" Honor an .editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Include gitlab for fugitive
let g:fugitive_gitlab_domains = ['https://gitlab.zgtools.net']

" set foldnestmax=3
" set foldlevel=1
" set foldminlines=1
" autocmd BufWinLeave *.* mkview
" autocmd BufWinEnter *.* silent loadview

" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/log/*,*/bin/*,*.rdb,*/solr/*,*vendor/bundle/*
set dictionary+=$HOME/.vim/dictionaries/rails-status-codes.txt
let g:ruby_path = system('echo $HOME/.rbenv/shims')
let g:coc_node_path = "/Users/ericst/.zillow-bootstrap/files/nvm/versions/node/v18.16.0/bin/node"
" let g:coc_node_path = trim(system('nvm which 18'))

" NERDTree Mappings "
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['node_modules[[dir]]']
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
" let NERDTreeQuitOnOpen = 1
nmap <silent><C-g> :NERDTreeToggle .<CR>

" Notes

let g:notes_directories = ['~/Dropbox/notes']
let g:notes_smart_quotes = 0
let g:notes_conceal_code = 0
nmap <silent><Leader>mr :MostRecentNote<CR>

" Github Copilot "

let g:copilot_filetypes = {
\ 'notes': v:false,
\ }


" YouCompleteMe

" let g:ycm_collect_identifiers_from_tag_files = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_seed_identifiers_with_syntax = 1

" Ale "
" let g:airline#extensions#ale#enabled = 1
" let g:ale_sign_error = '!' " Less aggressive than the default '>>'
" let g:ale_sign_warning = '?'
" let g:ale_lint_on_enter = 0 " Less distracting when opening a new file
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
" let g:ale_fix_on_save = 1
" let g:ale_fixers = {'javascript': ['standard']}
" let g:ale_linters = {'javascript': ['standard']}
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_scss_sass_quiet_messages = { 'regex': 'File to import not found' }
" let g:syntastic_ruby_checkers = ['mri', 'rubocop']
" let g:syntastic_javascript_checkers = ['standard']
" let g:syntastic_check_on_wq = 0
" let g:syntastic_auto_loc_list = 1

" Stadard.js "
" Automatically fixup JS using standardjs "
" autocmd bufwritepost *.js silent !standard --fix %

" Coc.vim"
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references-used)

" Code Actions
nmap <Leader><CR> <Plug>(coc-codeaction-curosr)
vmap <Leader><CR> <Plug>(coc-codeaction-selected)

" Formatting
nmap <Leader>fi <Plug>(coc-fix-current)
nmap <Leader>fo <Plug>(coc-format)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Ultisnips "

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Reload .vimrc when saved
" augroup vimrcReload
"   au!
"   silent autocmd bufwritepost .vimrc source $MYVIMRC | syntax enable
" augroup END

" CtrlP settings
let g:ctrlp_root_markers = ['Gemfile', 'Rakefile']
let g:ctrlp_dont_split = 'nerdtree'
let g:ctrlp_extensions = ['dir', 'tag']
let g:ctrlp_switch_buffer = 'ET'
let g:ctrlp_regexp = 1

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" Set Leader and leader bindings "
let mapleader = " "
nmap <Leader>= gg=G
nmap <Leader>e :TestSuite<CR>
nmap <Leader>t :TestFile<CR>
nmap <Leader>tt :TestLast<CR>
nmap <Leader>r :TestNearest<CR>
nmap <Leader>q :bd<CR>
nmap <Leader>Q :quit<CR>
nmap <Leader>w :write<CR>
nmap <Leader>vn :vne<CR>
nmap <Leader>wn :call SaveNote('note')<CR>
nmap <Leader>x :x<CR>
nmap <Leader>2 @q<CR>
" nmap <Leader><Leader> <C-^>
nmap <Leader>6 :vsplit #<CR>
nmap <Leader>cp :let @* = expand("%")<CR>
nmap <Leader>] :Dash<CR>
nmap <Leader><Tab> <C-w>p
nmap <Leader>z 1z=
nmap <Leader>d :GFiles<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>f :History<CR>
nmap <Leader>c :Tags<CR>
" nmap <Leader>f :CtrlP<CR>
" nmap <Leader>b :CtrlPBuffer<CR>
" nmap <Leader>d :CtrlPMRU<CR>
" nmap <Leader>c :CtrlPTag<CR>
nmap <Leader>n :cn<CR>
nmap <Leader>p :cp<CR>
nmap <Leader>aa :A<CR>
nmap <Leader>av :AV<CR>
nmap <Leader>as :AS<CR>
nmap <Leader>rr :R<CR>
nmap <Leader>rv :RV<CR>
nmap <Leader>rs :RS<CR>
nmap <Leader>? :h <C-R><C-W><CR>
nmap <Leader>jf :YcmCompleter GoToReferences<CR>
nmap <Leader>// :%s/<C-R><C-W>//g<left><left>
nmap <Leader>/ :Rg <C-R><C-W><CR>
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>' :s/"/'/g<CR>
nmap <Leader>no :Note<CR>
nmap <Leader>rev :windo source $MYVIMRC <Bar> syntax on<CR>
nmap <Leader>ev :tabedit $MYVIMRC<CR>
nmap <Leader>u :NERDTreeFind<CR>
nmap <Leader>arg :args `ag -l <C-R><C-W>`<CR>
" nmap <Leader>fi :!standard --fix %<CR>
nmap <Leader>~ vg_S~

" Git Gutter
nmap ]h <Plug>(GitGutterNextHunk)

nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>ga <Plug>(GitGutterStageHunk)
nmap <Leader>gu <Plug>(GitGutterUndoHunk)

" Add undo Breaks for insert mode
" inoremap <Space> <Space><C-G>u
inoremap <CR> <CR><C-G>u
inoremap <C-D> <C-D><C-G>u

" Vim Test "
let test#strategy = 'dispatch'
" let g:dispatch_compilers = {}
" let g:dispatch_compilers['node-modules/.bin/mocha-webpack'] = 'mocha-webpack'
" let g:dispatch_compilers['mocha-webpack'] = 'mocha-webpack'

let g:test#javascript#runner = 'jest'
" let g:test#runner_commands = ['Minitest', 'Mocha']
" let test#ruby#rspec#options = '--format p --no-color'
" let test#ruby#rspec#executable = 'docker-compose exec se ./bin/rspec'
" let test#ruby#rspec#executable = './bin/rspec'
" let test#javascript#mocha#executable = 'npx jest'
" let test#javascript#mocha#strategy = 'iterm'
" let test#javascript#mocha#options = {
"       \'nearest': '-R tap',
"       \'file': '-R tap',
"       \'suite': '"test/javascripts/**/*.js" -R tap'
"       \}


" Rspec Mappings "
" let g:rspec_command = "silent !/Users/eric/.vim/bundle/vim-rspec/bin/os_x_iterm 'bundle exec rspec {spec}'"
" nmap <Leader>t :call RunCurrentSpecFile()<CR>
" nmap <Leader>r :call RunNearestSpec()<CR>

" Rubocop Mappings "
" let g:vimrubocop_keymap = 0
" nmap <Leader>ru :Dispatch RuboCop<CR>

nnoremap Y yg_
imap <C-r><C-r> <C-r>"
map <silent> <Up> gk
map <silent> <Down> gj
map <silent> <home> g<home>
map <silent> <End> g<End>
map <silent> <Left> :N<CR>
map <silent> <Right> :n<CR>
imap <silent> <Up> <C-o>gk
imap <silent> <Down> <C-o>gj
imap <silent> <home> <C-o>g<home>
imap <silent> <End> <C-o>g<End>
vnoremap . :normal .<CR>

"move to the split in the direction shown, or create a new split
nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

" Yank the current buffer as a file link "
nmap <silent> <Leader>kf :let @*= "file://" . join([expand("%:p"), line(".")], ':')<CR>

" Open fountain or markdown files in Marked.app "
:nnoremap <leader>ma :silent !open -a Marked\ 2.app '%:p'<cr>

" " RTF Code Examples "
" let g:html_font="inconsolata"
" let g:html_number_lines=0
" let g:copy_as_rtf_using_local_buffer=1

" nmap <Leader>y :YankRtf<CR>
" vmap <Leader>y :YankRtf<CR>

" fu! YankRtf(line1, line2) range
"   colorscheme github
"   if exists("b:rails_root")
"     execute ":Rrefresh!"
"   end
"   execute ":silent " . a:line1 . "," . a:line2 . "CopyRTF"
"   colorscheme jellybeans
"   if exists("b:rails_root")
"     execute ":Rrefresh!"
"   end
" endf

command! -range=% YankRtf :call YankRtf(<line1>,<line2>)
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Set json_builder syntax to ruby "
autocmd BufNewFile,BufRead *.json_builder   set syntax=ruby

function! SaveNote(filename) range
  let l:extension = '.' . fnamemodify( a:filename, ':e' )
  if len(l:extension) == 1
    let l:extension = '.txt'
  endif

  let l:filename = '/Users/eric/Dropbox/notes/' . escape( fnamemodify(a:filename, ':r') . strftime("-%Y-%m-%d_%H-%M") . l:extension, ' ' )

  execute "write " . l:filename
endfunction

command! -nargs=1 SaveNote call SaveNote( <q-args> )

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Automatically strip trailing whitespace at file write
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
