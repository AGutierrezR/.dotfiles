# Initial
alias dotfiles="vim $DOTFILES"
alias zrc='vim ~/.zshrc'
alias zenv='vim ~/.zshenv'
alias aliases="vim $DOTFILES/zsh/.aliases.zsh"
alias galiases="vim $DOTFILES/git/.gitconfig"
alias reload='source ~/.zshrc'
alias s="reload"
# alias c="clear"
alias vim='nvim'
alias cvim="rm -rf ~/.local/share/nvim"
alias tm="tmuxifier"
alias t="tmux"
alias ta="tmux a"
alias tk="tmux kill-server"
# alias cc="clear && tmux clear-history"
alias zrm="zoxide query -l | fzf -m | xargs -I {} zoxide remove {}"

# # Easier Navigation
# if command -v zoxide &> /dev/null; then
#   alias cd='z'
# fi

alias ..='cd ..'
alias ...='cd ../..'

# ls stuff
alias l='ls -lah'
alias ll='ls -l'
alias ls='ls -G'
alias ldot='ls -ld .*'
alias lt='ls -ltFho'


# Functions
function take() {
  mkdir -p $1
  cd $1
}

# This function replace c and cc aliases
function c() {
  clear
  if ! [[ -z $TMUX ]]; then
    tmux clear-history
  fi
}

function dev-versions() {
  echo "node version: $(node -v)"
  echo "npm version: $(npm -v)"
  echo "pnpm version: $(pnpm -v)"
}

# NPM Aliases
alias nv='node -v'
alias npmc='rm -fr node_modules package-lock.json pnpm-lock.yaml yarn.lock'

function npmi() {
  # Removing NPM related stuff
  echo "Removing NPM related stuff"
  rm -rf package-lock.json
  rm -rf node_modules/
  # npm cache clean -f --force

  # Installing NPM
  echo "NPM Install..."
  until npm install;
  do
      printf '\e[31;1mError installing components.\e[0m\n'
      printf '\e[31;1m...Retrying in 3 seconds.\e[0m\n'
          sleep 3
  done
  printf '\e[32m-npm install- finished  \e[0m\n'

  afplay /System/Library/Sounds/Glass.aiff -v 5
}

function npm-install-local() {
  if [ -z "$1" ]; then
    echo "❌ You must provide a local package path. Example: npm-install-local ../my-local-package"
    return 1
  fi

  local local_package=$1

  if [ ! -d "$local_package" ]; then
    echo "❌ The provided path does not exist or is not a directory: $local_package"
    return 1
  fi

  if [ ! -f "$local_package/package.json" ]; then
    echo "❌ The provided path does not contain a package.json file: $local_package"
    return 1
  fi

  echo "🔗 Linking local package: $local_package"
  local package_name=$(node -pe "require('$local_package/package.json').name")

  echo "🧹 Removing node_modules/$package_name..."
  rm -rf "node_modules/$package_name"

  echo "📦 Installing $package_name from $local_package..."
  npm install --install-links $local_package

  afplay /System/Library/Sounds/Glass.aiff -v 5
}

function npm-reinstall() {
  if [ -z "$1" ]; then
    echo "❌ You must provide a package name. Example: npm-reinstall axios"
    return 1
  fi

  local package="$1"
  local package_name

  # Extract package name (without version)
  if [[ "$package" == @*/*@* ]]; then
    # e.g: @babel/core@7.22.0
    package_name="${package%@*}"
  elif [[ "$package" == @*/* ]]; then
    # e.g: @babel/core
    package_name="$package"
  else
    # e.g: axios o axios@1.5.0
    package_name="${package%@*}"
  fi

  echo "🧹 Removing node_modules/$package_name..."
  rm -rf "node_modules/$package_name"

  echo "📦 Reinstalling $package..."
  npm install --save-exact "$package"

  afplay /System/Library/Sounds/Glass.aiff -v 5
}

alias yz="yazy"
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

function gi() {
    local query="$@"
    local url="https://www.toptal.com/developers/gitignore/api/$query"
    local result

    # Fetch the .gitignore template
    echo "curl -sL $url"
    result=$(curl -sL "$url" 2>&1)
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to fetch data from $url (network or curl issue)."
        return 1
    fi

    # Handle 'list' command
    if [[ "$1" == "list" ]]; then
        echo "$result"
        return 0
    fi

    # Check if .gitignore exists
    if [[ -f .gitignore ]]; then
        echo "Appending to existing .gitignore for query: $query"
        echo "$result" >> .gitignore
    else
        echo "Creating new .gitignore for query: $query"
        echo "$result" > .gitignore
    fi

    echo "Successfully added .gitignore entries for '$query'."
}

alias ignore="gi vim,node,visualstudiocode,macos,linux,windows"

# {{{ Suffix aliases

alias -s json=jless
alias -s js="$EDITOR"
alias -s md=bat
alias -s txt=bat
alias -s log=bat

# }}} End of suffix aliases

# Inspired by https://www.youtube.com/watch?v=3fVAtaGhUyU
# Clear screen but keep current command buffer
function clear-screen-and-scrollback() {
  echoti civis >"$TTY"
  printf '%b' '\e[H\e[2J\e[3J' >"$TTY"
  echoti cnorm >"$TTY"
  zle redisplay
}
zle -N clear-screen-and-scrollback
bindkey '^Xl' clear-screen-and-scrollback

# Copy current command buffer to clipboard (macOS)
function copy-buffer-to-clipboard() {
  echo -n "$BUFFER" | pbcopy
  zle -M "Copied to clipboard"
}
zle -N copy-buffer-to-clipboard
bindkey '^Xc' copy-buffer-to-clipboard

function nic() {
  local dirname="${1:-$(basename "$PWD")}"
  local session_name=$(basename "$dirname" | tr . _)

  # Function to setup the pane layout
  setup_layout() {
    local target="$1"
    
    # Split the window/pane right for AI (32% width)
    tmux split-window -h -t "$target" -c "$PWD" -l 32%
    
    # Pane layout: 1=neovim (left), 2=opencode (right)
    tmux send-keys -t "$session_name":1.1 'nvim' C-m
    tmux send-keys -t "$session_name":1.2 'opencode' C-m
    
    # Focus on neovim pane
    tmux select-pane -t "$session_name":1.1
  }

  # If we're not inside tmux
  if [[ -z $TMUX ]]; then
    # Check if session doesn't exist and create it
    if ! tmux has-session -t "$session_name" 2>/dev/null; then
      echo "Creating new tmux session: $session_name"
      tmux new-session -d -s "$session_name" -c "$PWD" -x "$(tput cols)" -y "$(tput lines)"
    fi
    
    # Setup layout and attach (works for both existing and new sessions)
    setup_layout "$session_name":1
    tmux attach-session -t "$session_name"
  else
    # We're inside tmux, just create panels in current session
    setup_layout "$session_name":1.1
  fi
}
