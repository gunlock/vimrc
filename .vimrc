
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Patch for VAM git check out functions when behind proxy/firewall and git protocol is blocked
" and https is required
fun! MyGitCheckout(repository, targetDir)
  let a:repository.url = substitute(a:repository.url, '^git://github', 'https://github', '')
  return vam#utils#RunShell('git clone --depth=1 $.url $p', a:repository, a:targetDir)
endfun

" Set up VAM - VIM Addon Manager
fun! SetupVAM()
  let g:vim_addon_manager = {'scms': {'git': {}}}
  let c = get(g:, 'vim_addon_manager', {})
  " Apply MyGetCheckout patch (see above)
  let g:vim_addon_manager.scms.git.clone=['MyGitCheckout']
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 https://github.com/MarcWeber/vim-addon-manager.git'
       \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
   

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

" VAM addons
VAMActivate Auto_Pairs indentLine UltiSnips YouCompleteMe



" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
set backspace=2 " make backspace work like most other apps

" Enhanced keyboard mappings
"
" shortcut for <esc>
:inoremap jk <esc>

" <C-o> is used to issue Normal mode command without exiting insert mode
inoremap <C-e> <C-o>A
inoremap <C-a> <C-o>I

" Remap leader key
let mapleader = "\<Space>"

" indentLine
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'
let g:indentLine_char = '.'

" SnipMate

