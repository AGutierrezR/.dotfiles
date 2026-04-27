# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##################################
### Added by Zinit's installer
##################################
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
##################################
### End of Zinit's installer chunk
##################################

# Plugins
# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add zsh-syntax-highlighting and zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
# Setting autosuggestions accept and partial accept triggers
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line vi-add-eol)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char vi-forward-char)

# Add Aloxaf/fzf-tab
zinit light Aloxaf/fzf-tab
zinit light junegunn/fzf-git.sh

# Add q for macros
zinit light cal2195/q

# Add scripts to PATH
export PATH="$HOME/bin/.local/scripts:$PATH"
export PATH="$HOME/.tmuxifier/bin/:$PATH"

# Add completions and aliases
source $DOTFILES/zsh/.completion.zsh
source $DOTFILES/zsh/.bindkey.zsh
source $DOTFILES/zsh/.aliases.zsh

# Source user-specific aliases if the files exists
if [ -f $HOME/.zsh_aliases ]; then
  source $HOME/.zsh_aliases
fi

# Load fzf keybindings and completions
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="
  --walker-skip .jj,.git,node_modules"
export FZF_CTRL_T_OPTS="
  --preview='less {}' --height=100% 
  --bind shift-up:preview-page-up,shift-down:preview-page-down"

# History
HISTSIZE=10000                  # Max number of history entries
HISTFILE=~/.zsh_history         # Location of the history file
SAVEHIST=$HISTSIZE              # Number of commands to save
HISTDUP=erase                   # Avoid duplicate entries
setopt appendhistory            # Append history instead of overwriting
setopt sharehistory             # Share history across terminals
setopt hist_ignore_space        # Ignore commands starting with a space
setopt hist_ignore_all_dups     # Ignore duplicate entries across sessions
setopt hist_save_no_dups        # Avoid saving duplicates in history
setopt hist_ignore_dups         # Ignore duplicates commands
setopt hist_find_no_dups        # Prevent duplicates in history searches

# Initialize and zoxide
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

# Setting up Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

export EDITOR="nvim"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


