#!/usr/bin/env bash
# Hook bash/rc.bash into ~/.bashrc. Safe to re-run.
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "$0")" && pwd -P)
BASHRC=${1:-$HOME/.bashrc}
SOURCE_LINE="source \"$SCRIPT_DIR/rc.bash\""
COMMENT='# dotfiles: history, prompt, node, fzf, tmux notify, aliases'

# lines rc.bash now owns: old tmux-notify hook and the nvm installer's eager loader
is_replaced() {
    [[ "$1" == "$SOURCE_LINE" || "$1" == "$COMMENT" ]] ||
        [[ "$1" == source\ \"*/tmux-notify\" || "$1" == '# Notify tmux when long-running Bash commands finish.' ]] ||
        [[ "$1" == 'export NVM_DIR="$HOME/.nvm"' || "$1" == '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'* ||
            "$1" == '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'* ]]
}

touch "$BASHRC"
cp -- "$BASHRC" "$BASHRC.bak"
TEMP_FILE=$(mktemp)
trap 'rm -f -- "$TEMP_FILE"' EXIT
inserted=0
while IFS= read -r line || [[ -n "$line" ]]; do
    is_replaced "$line" && continue
    # SDKMAN wants to stay last in ~/.bashrc
    if (( ! inserted )) && [[ "$line" == *SDKMAN* || "$line" == *sdkman-init.sh* ]]; then
        printf '%s\n%s\n' "$COMMENT" "$SOURCE_LINE" >> "$TEMP_FILE"
        inserted=1
    fi
    printf '%s\n' "$line" >> "$TEMP_FILE"
done < "$BASHRC"
(( inserted )) || printf '%s\n%s\n' "$COMMENT" "$SOURCE_LINE" >> "$TEMP_FILE"
cat -- "$TEMP_FILE" > "$BASHRC" # keep the file's permissions
printf 'Hooked %s into %s (backup: %s.bak)\n' "$SCRIPT_DIR/rc.bash" "$BASHRC" "$BASHRC"
