set guioptions-=T
set guioptions-=r
set guioptions-=e
set guioptions-=L
" set macligatures
" set guifont=Fira\ Code\ Light:h16
" set guifont=Fantasque\ Sans\ Mono:h16
set antialias
set clipboard=unnamed

map <D-h> <C-W>h
map <D-k> <C-W>k
map <D-j> <C-W>j
map <D-l> <C-W>l
imap <D-d> :CtrlP

" TABS: Firefox style, open tabs with command-<tab number>
  map <silent> <D-1> <Esc>:tabn 1<CR>
  map <silent> <D-2> <Esc>:tabn 2<CR>
  map <silent> <D-3> <Esc>:tabn 3<CR>
  map <silent> <D-4> <Esc>:tabn 4<CR>
  map <silent> <D-5> <Esc>:tabn 5<CR>
  map <silent> <D-6> <Esc>:tabn 6<CR>
  map <silent> <D-7> <Esc>:tabn 7<CR>
  map <silent> <D-8> <Esc>:tabn 8<CR>
  map <silent> <D-9> <Esc>:tabn 9<CR>

" don't unselect after move
  vmap < <gv
  vmap > >gv
  vmap <TAB> >gv
  vmap <S-TAB> <gv

" bind command-] to shift right
  nmap <D-]> >>
  vmap <D-]> >>
  imap <D-]> <C-O>>>

" bind command-[ to shift left
  nmap <D-[> <<
  vmap <D-[> <<
  imap <D-[> <C-O><<
