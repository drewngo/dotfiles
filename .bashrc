alias ls='ls -v --color=auto'
alias l='ls -lF'
alias la='ls -lAF'
alias lr='ls -ltrF'
alias lt='ls -ltF'
alias lsa='ls -A'

# Restores terminal color support while using screen
alias screen='screen -T xterm'

PROMPT_NAME_MODE=host

set_prompt() {
  local rc=$?

  local txtred='\e[0;31m'
  local txtgrn='\e[0;32m'
  local txtblu='\e[1;34m'
  local txtpur='\e[1;35m'
  local txtwht='\e[1;37m'
  local txtrst='\e[0m'

  PS1="\n"

  # User or hostname
  if [[ "$PROMPT_NAME_MODE" == "user" ]]; then
      PS1+="\[$txtgrn\]\u\[$txtrst\] "
  else
      PS1+="\[$txtgrn\]\h\[$txtrst\] "
  fi

  # Exit code
  if [[ $rc -eq 0 ]]; then
      PS1+="\[$txtgrn\]:) $rc\[$txtrst\] "
  else
      PS1+="\[$txtred\]:( $rc\[$txtrst\] "
  fi

  # Directory
  PS1+="\[$txtblu\]\w\[$txtrst\]"

  # Git branch
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
      git_branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"
      PS1+=" \$git_branch\[$txtrst\]"
  fi

  PS1+="\n"
  PS1+="\[$txtwht\]>\[$txtrst\] "
}

PROMPT_COMMAND=''

toggle_name() {
  if [[ "$PROMPT_NAME_MODE" == "host" ]]; then
      PROMPT_NAME_MODE=user
  else
      PROMPT_NAME_MODE=host
  fi
}

alias tph='toggle_name'

function togglePrompt {
  if [ -n "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND=''
    PS1="$PS1_OLD"
  else
    PS1_OLD="$PS1"
    PROMPT_COMMAND='set_prompt'
  fi
}

togglePrompt

#PATH
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Library/PostgreSQL/18/bin:$PATH"
