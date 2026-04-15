# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# add fzf-git integration if the file exists
if [ -f "$DOTFILES/fzf/fzf-git.sh" ];then
  source $DOTFILES/fzf/fzf-git.sh
fi

# History settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Initialize starship prompt and zoxide
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

# Setting up syntax highlighting and autosuggestions
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# Setting autosuggestions accept and partial accept triggers
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line vi-add-eol)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char vi-forward-char)

# Setting up Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
