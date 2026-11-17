export BASH_SILENCE_DEPRECATION_WARNING=1

eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"
export PATH="/Library/PostgreSQL/18/bin:$PATH"
export PATH="$PATH:$HOME/.lmstudio/bin"

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
