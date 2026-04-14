#!/bin/bash

link_file () {
  local src=$1 dst=$2
  local overwrite=
  local backup=
  local skip=
  local action=

  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]; then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

      # Ignoring exist 1 from readlink in case where file alredy exist
      local currentSrc="$(readlink "$dst")"

      if [ "$currentSrc" == "$src" ]; then
        skip=true
      else
        echo "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action < /dev/tty
        case "$action" in
          o ) overwrite=true ;;
          O ) overwrite_all=true ;;
          b ) backup=true ;;
          B ) backup_all=true ;;
          s ) skip=true ;;
          S ) skip_all=true ;;
          * ) ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      echo "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      mv "$dst" "${dst}.backup"
      echo "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      echo "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]; then
    ln -s "$1" "$2"
    echo "linked $1 to $2"
  fi
}

unlink_file () {
  local src=$1 dst=$2

  if [ -L "$dst" ]; then
    rm "$dst"
    echo "unlinked $dst"

    if [ -f "${dst}.backup" ]; then
      mv "${dst}.backup" "$dst"
      echo "restored backup $dst"
    fi
  fi
}

unlink_dotfiles () {
  echo 'Unlinking dotfiles'

  find -H "$DOTFILES" -maxdepth 4 -name 'links.prop' -not -path '*.git*' | while read linkfile; do
    cat "$linkfile" | while read line; do

      local src dst dir
      src=$(eval echo "$line" | cut -d '=' -f 1)
      dst=$(eval echo "$line" | cut -d '=' -f 2)

      unlink_file "$src" "$dst"

    done
  done
}

install_dotfiles () {
  echo 'Installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  find -H "$DOTFILES" -maxdepth 4 -name 'links.prop' -not -path '*.git*' | while read linkfile; do
    cat "$linkfile" | while read line; do

      local src dst dir
      src=$(eval echo "$line" | cut -d '=' -f 1)
      dst=$(eval echo "$line" | cut -d '=' -f 2)

      dir=$(dirname "$dst")
      mkdir -p "$dir"
      link_file "$src" "$dst"

    done
  done
}

function ask() {
  read -p "$1 (Y/n): " response
  [ -z "$response" ] || [ "$response" = "y" ]
}
