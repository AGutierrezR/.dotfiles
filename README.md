# Dotfiles

Portable development environment configuration for macOS with Homebrew.

## Installation

```bash
git clone https://github.com/AGutierrezR/.dotfiles.git ~/.dotfiles
sh ~/.dotfiles/install/bootstrap.sh
```

The bootstrap script will:
- Install Xcode Command Line Tools
- Install Homebrew (if not present)
- Install packages from Brewfile
- Link all configuration files using `links.prop`

## CLI Tools

- [atuin](https://github.com/atuinsh/atuin)
- [bat](https://github.com/sharkdp/bat)
- [clipboard](https://github.com/Slackadays/clipboard)
- [csvlens](https://github.com/YS-L/csvlens)
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [gh](https://github.com/cli/cli)
- [gh-dash](https://github.com/dlvhdr/gh-dash)
- [git](https://git-scm.com)
- [gum](https://github.com/charmbracelet/gum)
- [tuicr](https://tuicr.dev/)
- [jj](https://github.com/jj-vcs/jj)
- [jless](https://jless.io)
- [jq](https://jqlang.github.io/jq/)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [marksman](https://github.com/artempyanykh/marksman)
- [mise](https://github.com/jdx/mise)
- [moxide](https://github.com/so-dang-cool/moxide)
- [mpd](https://www.musicpd.org/)
- [mprocs](https://github.com/pvolok/mprocs)
- [neovim](https://neovim.io)
- [pnpm](https://pnpm.io)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [rm-improved](https://github.com/nivekuil/rip)
- [rmpc](https://github.com/ammgws/rmpc)
- [taproom](https://github.com/alebcay/taproom)
- [tldr](https://github.com/tldr-pages/tldr)
- [tmux](https://github.com/tmux/tmux)
- [tree](https://oldmanprogrammer.net/source.php?dir=projects/tree)
- [worktrunk](https://github.com/pluots/worktrunk)
- [yazi](https://github.com/sxyazi/yazi)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [zsh-plugins](https://github.com/zsh-users)

## Apps

- [bruno](https://www.usebruno.com)
- [figma](https://figma.com)
- [ghostty](https://ghostty.org)
- [imageoptim](https://imageoptim.com)
- [kap](https://kap.ly)
- [keka](https://www.keka.io)
- [keycastr](https://github.com/keycastr/keycastr)
- [raycast](https://raycast.com)
- [spotify](https://spotify.com)
- [tempbox](https://github.com/devplayer0/tempbox)
- [transnomino](https://transnomino.bastiaanverreijt.com)
- [vlc](https://www.videolan.org/vlc/)

## Extras

Install additional apps and CLI tools:

```bash
sh ~/.dotfiles/install/tools.sh apps
sh ~/.dotfiles/install/tools.sh cli
```

## Homebrew

Export installed packages:
```bash
brew bundle dump --describe
```

Import from Brewfile:
```bash
brew bundle
```
