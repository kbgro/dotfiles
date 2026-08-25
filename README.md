# Dotfiles

Personal configuration files for my development environment.

Structure
```
.
├── alacritty/    # Alacritty terminal configuration
├── nvim/         # Neovim configuration
├── opencode/     # OpenCode configuration and themes
└── tmux/         # Tmux configuration and extensions
```

## Components

### Alacritty

Configuration for the Alacritty terminal emulator.

* alacritty.toml — current configuration
* alacritty.yml — legacy/alternative configuration

### Neovim

My Neovim configuration, written in Lua.

The configuration is organized into:

* init.lua — entry point
* options.lua — editor options
* mappings.lua — key mappings
* autocmds.lua — autocommands
* filetypes.lua — filetype configuration
* configs/ — plugin-specific configuration
* plugins/ — plugin declarations
* lazy-lock.json — plugin lockfile

### OpenCode

Configuration for OpenCode.

* opencode.json — OpenCode configuration
* tui.json — TUI configuration
* themes/ — custom themes

### Tmux

Configuration and extensions for tmux.

* tmux.conf — main configuration
* extensions/ — custom tmux extensions
* README.md — tmux-specific documentation

## Installation

Clone the repository:

```sh
git clone <repository-url> ~/dotfiles
cd ~/dotfiles
```

Then symlink the configuration files into their expected locations.

For example:

```sh
ln -s "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
ln -s "$HOME/dotfiles/alacritty" "$HOME/.config/alacritty"
ln -s "$HOME/dotfiles/opencode" "$HOME/.config/opencode"
```

For tmux:

`ln -s "$HOME/dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"`

Adjust the paths as needed for your environment.

## Notes

These are personal dotfiles and may assume specific tools, plugins, fonts, or system packages are installed. Configuration may need to be adapted before use on another machine.
