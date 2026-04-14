# Tmux Configuration

This directory contains the tmux configuration files.

## Plugins

This configuration uses [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm) to manage plugins.

To install plugins:
```
prefix + I
```

To update plugins:
```
prefix + U
```

To remove plugins, edit the plugin list in `.tmux.conf` and restart tmux.

## Reload

To reload the configuration file without restarting tmux:
```
prefix + r
```

This will reload `.tmux.conf` and apply the changes immediately.

**Note:** The prefix key is `Ctrl + a` (instead of the default `Ctrl + b`).