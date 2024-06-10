
eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -r ~/.zshrc ]; then
  if ! grep -q 'export GPG_TTY=$(tty)' ~/.zshrc; then
    echo -e '\nexport GPG_TTY=$(tty)' >> ~/.zshrc;
  fi
else
  echo -e '\nexport GPG_TTY=$(tty)' >> ~/.zprofile; 
fi
