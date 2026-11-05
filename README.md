# Dotfiles

Personal configuration files for my development environment.

Structure
```
.
├── alacritty/    # Alacritty terminal configuration
├── bash/         # Bash config hooked into ~/.bashrc
├── devbox/       # Local VM manager
├── fall/         # Personal development package manager
├── nvim/         # Neovim configuration
├── opencode/     # OpenCode configuration and themes
└── tmux/         # Tmux configuration and extensions
```

## Components

### Alacritty

Configuration for the Alacritty terminal emulator.

* alacritty.toml — configuration

### Bash

The dotfiles own only part of the shell setup; `~/.bashrc` stays machine-local.

* rc.bash — history (100k lines, shared across tmux panes), Starship, zoxide,
  fzf key bindings (Ctrl-R history, Ctrl-T files, Alt-C cd), lazy nvm,
  tmux command notifications, aliases
* setup.sh — adds one line to `~/.bashrc` that sources rc.bash (safe to
  re-run, keeps a `~/.bashrc.bak`), and removes the nvm installer's eager
  loader lines, which rc.bash replaces

`nvm` itself loads only when you first run it; the newest installed Node is put
on `PATH` directly so `node`, `npm` and global tools work without it.

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

Tests for the scripts live next to them: `bash/test/setup` and
`tmux/extensions/test/*`.

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

For tmux (the reload binding expects this path):

`ln -s "$HOME/dotfiles/tmux" "$HOME/.config/tmux"`

For Bash:

`~/dotfiles/bash/setup.sh`

Re-run it after installing nvm (the nvm installer adds its own loader back).

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
