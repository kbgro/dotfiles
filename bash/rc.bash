# Bash config owned by the dotfiles. bash/setup.sh adds a line to ~/.bashrc that sources this.
DOTFILES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)

# history: large, and appended after every command so all tmux panes share it
HISTSIZE=100000
HISTFILESIZE=200000

case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$PATH:$HOME/.local/bin" ;; esac

# node: put the newest installed node on PATH now; load nvm itself (~220ms) only when `nvm` is first run
# shortcut: picks the newest installed version, not nvm's default alias; fine while only one is installed
export NVM_DIR="$HOME/.nvm"
if [[ -s $NVM_DIR/nvm.sh ]]; then
    node_bin=$(ls -d "$NVM_DIR"/versions/node/v*/bin 2>/dev/null | sort -V | tail -1)
    [[ -n $node_bin ]] && PATH="$node_bin:$PATH"
    unset node_bin
    nvm() { unset -f nvm; . "$NVM_DIR/nvm.sh"; nvm "$@"; }
fi

command -v starship >/dev/null && eval "$(starship init bash)"
command -v zoxide >/dev/null && eval "$(zoxide init bash)"
command -v fzf >/dev/null && eval "$(fzf --bash)" # Ctrl-R history, Ctrl-T files, Alt-C cd

# after starship init, which replaces PROMPT_COMMAND
_history_append() { local status=$?; history -a; return "$status"; } # keep $? for the prompt
case ";$PROMPT_COMMAND;" in
    *';_history_append;'*) ;;
    *) PROMPT_COMMAND="_history_append${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac

source "$DOTFILES/tmux/extensions/bin/tmux-notify"

alias gloww='glow -w "$(tput cols)"'
if [[ -n ${TMUX:-} ]]; then
    alias gs='git status'
else
    alias tmh='tmux new-session -As "$(basename "$(dirname "$PWD")")/$(basename "$PWD")"'
fi
