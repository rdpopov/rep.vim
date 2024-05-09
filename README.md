# rep.vim

I have found the base completions modes of vim to be very versatile. However, I
think the key binds are long but make sense. I was using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp), I found that what I 
need is just the lsp. Or if I don't have one keyword or include completion is enough.  more specific completion I would just trigger it from vim, not from cmp, which makes it kinda pointless as an agregator. 

I found I only need them in small 'bursts' - I only need to repeat a completion type
for a few things in the span of a few lines but I want an easier retrigger. Eg: file paths. 

Autocompletion from lsp-type plugins always pops up automatically for lsp, and that is not a problem.

## How it works
It waits for when completion is triggered and
changes the mode to the triggered one. And on the next time the command is called,
the same completion is triggered. By default it starts in keyword mode.

If menu is already visible(either lsp pop-up or current completion), it just
goes to the next one or previous one depending on the mapping. Those can be
remapped.

## Extras
I store the current completion as a global variable, so just put it in the
status line.
``` vim
let g:Rep_current_completion = 'keyword'
```
Or
``` lua
local cmpl = vim.g.Rep_current_completion or ""
```

## Setup
There isn't much for setup. Install with plugin manager of choice. 

``` vim
Plug 'rdpopov/rep.vim'
```

And these are the keymaps I use.

Lua:

``` lua
local keymap = vim.api.nvim_set_keymap

-- override to something else, default is keyword completion
vim.g.Rep_current_completion = "keyword"

keymap('i','<Tab>', '<Plug>RepCompleteNext',{noremap = true, desc="Trigger completion or continue current, get next"})
keymap('i','<S-Tab>', '<Plug>RepCompletePrev',{noremap = true, desc="Trigger completion or continue current, get previous"})
```

``` vim
" override to something else, default is keyword completion
let g:Rep_current_completion = 'keyword'

inoremap <Tab> <Plug>RepCompleteNext
inoremap <S-Tab> <Plug>RepCompletePrev
```
