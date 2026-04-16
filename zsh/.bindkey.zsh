# Inspiration from:
# - https://github.com/von/homestuff/blob/main/home/dot_zsh.d/bindkey.zsh

# Set vi-mode in zsh
bindkey -v

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# {{{ VI insert mode bindings (viins)
bindkey -M viins '^?'    backward-delete-char
bindkey -M viins '^_'    undo

bindkey -M viins '^a'    beginning-of-line

bindkey -M viins '^e'    end-of-line
bindkey -M viins '^h'    backward-delete-char
bindkey -M viins '^k'    kill-line
# ^l clear-screen
# ^m accept-line
# bindkey -M viins '^n'    down-line-or-history
# bindkey -M viins '^p'    up-line-or-history
bindkey -M viins '^p'    history-search-backward
bindkey -M viins '^n'    history-search-forward
bindkey -M viins '^u'    kill-buffer

# Copy word prior word or prior word to last word copied
# Kudos: http://leahneukirchen.org/blog/archive/2013/03.html
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey -M viins "^x^x" copy-earlier-word

bindkey -M viins '\eOH'  beginning-of-line # Home
bindkey -M viins '\eOF'  end-of-line       # End
bindkey -M viins '\e[2~' overwrite-mode    # Insert
bindkey -M viins '\ef'   forward-word      # Alt-f
bindkey -M viins '\eb'   backward-word     # Alt-b
bindkey -M viins '\ed'   kill-word         # Alt-d
# }}} Vi insert mode bindings (viins)

# {{{ VI command mode keybindings (vicmd)
bindkey -M vicmd '^_'    undo
bindkey -M vicmd '^a'    beginning-of-line
bindkey -M vicmd '^e'    end-of-line
bindkey -M vicmd '^k'    kill-line
bindkey -M vicmd '^u'    kill-buffer
bindkey -M vicmd '^w'    backward-kill-word

# Unbind ':' from execute-named-command as I accidently enter ':wq' often
bindkey -M vicmd -r ':'

bindkey -M vicmd "^x^e"  edit-command-line

bindkey -M vicmd '\ef'   forward-word                      # Alt-f
bindkey -M vicmd '\eb'   backward-word                     # Alt-b
bindkey -M vicmd '\ed'   kill-word                         # Alt-d
# }}} Vi command mode keybindings (vicmd)

# Tmux sessionizer
bindkey -s ^f "tmux-sessionizer\n"

