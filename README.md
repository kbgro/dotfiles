# Dotfiles

Personal configuration files for my development environment.

Structure
```
.
├── alacritty/    # Alacritty terminal configuration
├── fall/         # Personal development package manager
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

For fall:

`mkdir -p "$HOME/.local/bin" && ln -s "$HOME/dotfiles/fall/bin/fall" "$HOME/.local/bin/fall"`

Install the .NET SDK with `fall install dotnet`. It downloads the pinned .NET 10.0.403 Linux x64 SDK tarball, extracts it under `~/.dotnet`, and configures Bash, Zsh, and POSIX login profiles.

Install Docker on Debian with `fall install docker`. This adds the current user to Docker's group; log out and back in afterward. Docker group membership grants root-level control of the host.

For a devbox guest, start the machine and copy `fall` into the guest user's local bin:

```sh
devbox up agent-01
devbox setup agent-01
devbox ssh agent-01
fall list
```

Choose and install guest packages from the SSH session, for example `fall install core`.

Adjust the paths as needed for your environment.

## Notes

These are personal dotfiles and may assume specific tools, plugins, fonts, or system packages are installed. Configuration may need to be adapted before use on another machine.
