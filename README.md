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

## Tools

**CLI:**
- [atuin](https://github.com/atuinsh/atuin)
- [fzf](https://github.com/junegunn/fzf)
- [git](https://git-scm.com)
- [jj](https://github.com/jj-vcs/jj)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [mise](https://github.com/jdx/mise)
- [mpd](https://www.musicpd.org/)
- [mprocs](https://github.com/pvolok/mprocs)
- [neovim](https://neovim.io)
- [pnpm](https://pnpm.io)
- [starship](https://starship.rs)
- [tmux](https://github.com/tmux/tmux)
- [yazi](https://github.com/sxyazi/yazi)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [zoxide](https://github.com/rash-dev/zoxide)
- [zsh-plugins](https://github.com/zsh-users)

**Apps:**
- [ghostty](https://ghostty.org)
- [raycast](https://raycast.com)
- [spotify](https://spotify.com)
- [figma](https://figma.com)
- [keka](https://www.keka.io)
- [vlc](https://www.videolan.org/vlc/)
- [bruno](https://www.usebruno.com)

## Extras

Install additional apps:
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
