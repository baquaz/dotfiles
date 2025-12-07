#!/bin/sh

# If inside tmux, behave normally
if [ -n "$TMUX" ]; then
  exec tmux "$@"
  exit
fi

# If arguments were passed (tmux new -s foo / attach / etc.)
if [ "$#" -gt 0 ]; then
  exec tmux "$@"
  exit
fi

# No args? Ask if user wants to name or skip
printf "New session name (leave empty for default): "
read NAME

if [ -z "$NAME" ]; then
  # User pressed Enter → fallback to tmux default
  exec tmux
else
  exec tmux new-session -s "$NAME"
fi
