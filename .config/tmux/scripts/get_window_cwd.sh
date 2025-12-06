#!/usr/bin/env bash
# Usage: get_window_cwd.sh <pane_pid>
pane_pid="$1"

# Function: shorten path
shorten_path() {
  local path="$1"
  [[ -z "$path" ]] && echo "" && return
  # Replace $HOME with ~
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

# Try to detect Nvim in pane
nvim_pid=$(pgrep -P "$pane_pid" nvim | head -n1)
if [[ -n "$nvim_pid" ]]; then
  # Use nvim remote to get cwd
  cwd=$(nvim --server /tmp/nvim-${nvim_pid} --remote-expr 'getcwd()' 2>/dev/null)
  [[ -n "$cwd" ]] && shorten_path "$cwd" && exit 0
fi

# Fallback: query tmux pane directly for cwd
pane_path=$(tmux list-panes -F "#{pane_pid} #{pane_current_path}" | awk -v pid="$pane_pid" '$1==pid {print $2}')
shorten_path "$pane_path"

#V2
# #!/usr/bin/env bash
# # Usage: get_window_cwd.sh <pane_pid>
#
# pane_pid="$1"
#
# # Function to shorten long paths like /home/user/projects/foo/bar -> ~/p/f/bar
# shorten_path() {
#   local path="$1"
#
#   # Replace $HOME with ~
#   path="${path/#$HOME/~}"
#
#   # Split path by /
#   IFS='/' read -r -a parts <<<"$path"
#
#   local n=${#parts[@]}
#
#   # Keep first ~ if present
#   local result=""
#   local start=0
#   if [[ "${parts[0]}" == "~" ]]; then
#     result="~"
#     start=1
#   fi
#
#   # Show last 3 segments, shorten middle segments to first letter
#   if ((n - start > 3)); then
#     for ((i = start; i < n - 2; i++)); do
#       [[ -n "${parts[i]}" ]] && result+="/${parts[i]:0:1}"
#     done
#     result+="/${parts[n - 2]}/${parts[n - 1]}"
#   else
#     for ((i = start; i < n; i++)); do
#       [[ -n "${parts[i]}" ]] && result+="/${parts[i]}"
#     done
#   fi
#
#   echo "$result"
# }
#
# # Detect Nvim in this pane
# nvim_pid=$(pgrep -P "$pane_pid" nvim | head -n1)
# if [ -n "$nvim_pid" ]; then
#   cwd=$(nvim --server /tmp/nvim-${nvim_pid} --remote-expr 'getcwd()' 2>/dev/null)
#   [[ -n "$cwd" ]] && shorten_path "$cwd" && exit 0
# fi
#
# # Fallback to pane current path
# pane_path=$(tmux display-message -p -F "#{pane_current_path}" -t "$pane_pid")
# shorten_path "$pane_path"

# V1
# #!/usr/bin/env bash
# # Usage: get_window_cwd.sh <pane_pid>
#
# pane_pid="$1"
#
# # Check if Nvim is running in this pane
# nvim_pid=$(pgrep -P "$pane_pid" nvim | head -n1)
#
# if [ -n "$nvim_pid" ]; then
#   # Try to get Nvim cwd (requires nvim 0.8+ with --server)
#   cwd=$(nvim --server /tmp/nvim-${nvim_pid} --remote-expr 'getcwd()' 2>/dev/null)
#   [ -n "$cwd" ] && echo "$cwd" && exit 0
# fi
#
# # Fallback to pane current path
# tmux display-message -p -F "#{pane_current_path}"
