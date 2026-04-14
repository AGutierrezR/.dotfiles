# # The following lines were added by compinstall
# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
# zstyle ':completion:*' original true
# zstyle :compinstall filename "$HOME/.zshrc"

# autoload -Uz compinit
# zstyle ':completion:*' menu select
# zmodload zsh/complist
# compinit
autoload -U compinit; compinit
source ~/.local/share/fzf-tab/fzf-tab.plugin.zsh

# Ensure colors match by using FZF_DEFAULT_OPTS.
zstyle ":fzf-tab:*" use-fzf-default-opts yes

# Preview file contents when tab completing directories.
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color=always \${realpath}"

# End of lines added by compinstall
