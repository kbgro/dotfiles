# Tmux Configuration

## Extensions

- tmh: tmux here, create tmux session in this directory.
- tmopen: fzf directory and Git worktree picker for tmux.
- azpr: fzf Azure DevOps pull-request picker for tmux.
- home-size: status-bar size of ~ and free space on /home (red at 95% full).

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
repositories/worktrees. `prefix+P` opens active Azure DevOps pull requests
with a live preview. `prefix+g` opens lazygit (`fall install lazygit`) in a
popup for the current pane's directory. `prefix+s` and `prefix+w` are fzf
pickers for sessions and for windows across all sessions.

In copy mode (`prefix+[` or mouse scroll) the keys work like vim: `v` starts a
selection, `Ctrl-v` toggles a block selection, `y` copies to the system
clipboard and exits.

### Azure pull requests

`azpr` requires the Azure DevOps extension for Azure CLI and an authenticated
`az` session. `prefix+P` first asks for a project, then shows its active PRs
with details and policy status. Use `m` to merge after confirmation or `a` to
enable auto-complete; Azure DevOps still enforces repository policies and
permissions.

### Bash command notifications

`bash/rc.bash` loads the prompt hook (run `~/dotfiles/bash/setup.sh` once).
Commands that run for five seconds or longer emit a terminal bell when their
prompt returns. tmux then marks the window in the status bar, lists it first
with a 🔔 in the `prefix+w` picker, and sends a desktop notification naming
`session:window` (skipped when you are already looking at that window).

### Session snapshots

`tmsave` records every session, window (name, layout) and pane folder in
`~/.local/state/tmux/snapshot.tsv`, keeping the previous five as `.1`–`.5`.
The status bar runs it every 5 minutes, but only once `tmrestore` has run on
the current server, so a fresh server after a crash cannot overwrite the good
snapshot. `prefix+C-s` saves now.

`tmrestore` runs once when the tmux server starts and recreates any saved
session that does not already exist; `prefix+C-r` runs it again. Programs and
scrollback are not restored, except that panes running `nvim`, `lazygit`,
`htop` or `btop` (override with `TMRESTORE_CMDS`) get the command started
again. To restore an older snapshot: `tmrestore ~/.local/state/tmux/snapshot.tsv.1`.

Test: `tmux/extensions/test/tmsave` (uses its own tmux server).

### Huddle notes

`huddle` works on `~/work/Huddle` (override with `HUDDLE_DIR`).

* `prefix+H` searches every note as you type (ripgrep, smart case) with a
  preview; Enter opens the line in nvim in a new `huddle` window.
* `prefix+T` shows today's note (`Notes/DD.MM.YY/today.md`) rendered with glow,
  or the latest note if today's doesn't exist yet. `q` closes it.
