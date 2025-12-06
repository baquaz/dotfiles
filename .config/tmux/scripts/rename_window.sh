#!/usr/bin/env bash
pane_id="$1"

# Function to shorten path like ~/p/f/bar
shorten_path() {
  local path="$1"
  [[ -z "$path" ]] && echo "" && return
  path="${path/#$HOME/~}"
  IFS='/' read -r -a parts <<<"$path"
  local n=${#parts[@]}
  local result=""
  local start=0
  if [[ "${parts[0]}" == "~" ]]; then
    result="~"
    start=1
  fi
  if ((n - start > 3)); then
    for ((i = start; i < n - 2; i++)); do
      [[ -n "${parts[i]}" ]] && result+="/${parts[i]:0:1}"
    done
    result+="/${parts[n - 2]}/${parts[n - 1]}"
  else
    for ((i = start; i < n; i++)); do
      [[ -n "${parts[i]}" ]] && result+="/${parts[i]}"
    done
  fi
  echo "$result"
}

# Determine pane PID
pane_pid=$(tmux display-message -p -t "$pane_id" "#{pane_pid}")
win_id=$(tmux display-message -p -t "$pane_id" "#{window_id}")
current_name=$(tmux display-message -p -F "#{window_name}" -t "$win_id")

# Respect manual renames: if name is not default (zsh, bash, AUTO), do nothing
if [[ "$current_name" != "zsh" && "$current_name" != "bash" && "$current_name" != "AUTO" ]]; then
  exit 0
fi

# Detect Nvim
nvim_pid=$(pgrep -P "$pane_pid" nvim | head -n1)
if [[ -n "$nvim_pid" ]]; then
  cwd=$(nvim --server /tmp/nvim-${nvim_pid} --remote-expr 'getcwd()' 2>/dev/null)
  [[ -n "$cwd" ]] && tmux rename-window "$(printf " %s" "$(shorten_path "$cwd")")" && exit 0
fi

# Otherwise, rename to terminal path
pane_path=$(tmux display-message -p -F "#{pane_current_path}" -t "$pane_id")
tmux rename-window "$(printf " %s" "$(shorten_path "$pane_path")")"
