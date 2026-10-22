# Tmux Configuration

## Extensions

- tmh: tmux here, create tmux session in this directory.
- tmopen: fzf directory and Git worktree picker for tmux.
- azpr: fzf Azure DevOps pull-request picker for tmux.

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
with a live preview. Existing session and window picker bindings are unchanged.

### Azure pull requests

`azpr` requires the Azure DevOps extension for Azure CLI and an authenticated
`az` session. `prefix+P` first asks for a project, then shows its active PRs
with details and policy status. Use `m` to merge after confirmation or `a` to
enable auto-complete; Azure DevOps still enforces repository policies and
permissions.

### Bash command notifications

Install the Bash prompt hook once:

```sh
~/dotfiles/tmux/extensions/bin/install-tmux-notify
```

It adds an idempotent source line to `~/.bashrc`. Commands that run for five
seconds or longer emit a terminal bell when their prompt returns, allowing the
existing tmux window notification marker to show which window finished. The
hook preserves the existing Starship and Bash prompt commands.

