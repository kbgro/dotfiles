# Tmux Configuration

## Extensions

- tmh: tmux here, create tmux session in this directory.
- tmopen: fzf directory and Git worktree picker for tmux.

### tmopen

`tmopen` must be run inside tmux. It opens a selected directory in a new
window, or switches to/creates a session with `--session`:

```sh
tmopen
tmopen --git
tmopen --session
tmopen --git --session
tmopen --roots ~/projects ~/dotfiles
```

Git mode lists repositories and linked worktrees with branch and dirty-state
information. It does not modify Git state.

Search roots are read from `${XDG_CONFIG_HOME:-$HOME/.config}/tmux/open-roots`,
one path per line. Blank lines and lines beginning with `#` are ignored. If the
file is absent or empty, `$HOME` is used.

The tmux bindings are `prefix+F` for directories and `prefix+G` for Git
repositories/worktrees. Existing session and window picker bindings are
unchanged.

