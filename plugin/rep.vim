" Nvim plugin to approximate selecion mode in helix/kakoune
"
" Maintainer: Me
" License: This file is placed in the public domain.
"
if exists("g:loaded_rep_vim") || &cp || v:version < 700
    finish
endif
let g:loaded_rep_vim = 1

" Default comletion is keyword
if !exists("g:Rep_current_completion")
    let g:Rep_current_completion = "keyword"
end

au CompleteChanged * :call s:special_tab_complete()

let s:rep_to_feed = { "" : "\<C-n>",
            \ "keyword" : "\<C-x>\<C-n>",
            \ "ctrl_x" : "\<C-n>",
            \ "scroll" : "\<C-x>\<C-s>",
            \ "whole_line" : "\<C-x>\<C-l>",
            \ "files" : "\<C-x>\<C-f>",
            \ "tags" : "\<C-x>\<C-]>",
            \ "path_defines" : "\<C-x>\<C-d>",
            \ "path_patterns" : "\<C-x>\<C-i>",
            \ "dictionary" : "\<C-x>\<C-k>",
            \ "thesaurus" : "\<C-x>\<C-k>",
            \ "cmdline" : "\<C-x>\<C-v>",
            \ "function" : "\<C-x>\<C-u>",
            \ "omni" : "\<C-x>\<C-o>",
            \ "spell" : "\<C-x>s",
            \ "eval" : "\<C-n>",
            \ "unknown" : "\<C-n>" }

let g:Rep_complete_command = get(s:rep_to_feed,g:Rep_current_completion,s:rep_to_feed["keyword"])

function s:special_tab_complete()
    let g:Rep_current_completion = complete_info()['mode'] 
    let g:Rep_complete_command = get(s:rep_to_feed,g:Rep_current_completion,s:rep_to_feed["keyword"])
endfunction

inoremap <expr> <Plug>RepCompleteNext pumvisible() ? "\<C-n>"  :  g:Rep_complete_command
inoremap <expr> <Plug>RepCompletePrev pumvisible() ? "\<C-p>"  :  g:Rep_complete_command
