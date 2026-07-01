alias ls='ls -v --color=auto'
alias l='ls -lF'
alias la='ls -lAF'
alias lr='ls -ltrF'
alias lt='ls -ltF'
alias lsa='ls -A'

# prompt from kolassa
function set_prompt {
  rc=$?

  txtblk='\e[0;30m'; bldblk='\e[1;30m' # Black  - Regular / Bold
  txtred='\e[0;31m'; bldred='\e[1;31m' # Red    - Regular / Bold
  txtgrn='\e[0;32m'; bldgrn='\e[1;32m' # Green  - Regular / Bold
  txtylw='\e[0;33m'; bldylw='\e[1;33m' # Yellow - Regular / Bold
  txtblu='\e[0;34m'; bldblu='\e[1;34m' # Blue   - Regular / Bold
  txtpur='\e[0;35m'; bldpur='\e[1;35m' # Purple - Regular / Bold
  txtcyn='\e[0;36m'; bldcyn='\e[1;36m' # Cyan   - Regular / Bold
  txtwht='\e[0;37m'; bldwht='\e[1;37m' # White  - Regular / Bold
  txtrst='\e[0m'                       # Text Reset

  ansiGreenCheck='\342\234\223'
  ansiRedX='\342\234\227'

  PS1="\n"

  ### The user@host section
  PS1+="\[$bldblk\][\[$txtrst\]"

    if [[ $EUID == 0 ]]; then
      PS1+="\[$txtred\]\u@\h\[$txtrst\]"
    else
      PS1+="\[$txtgrn\]\u@\h\[$txtrst\]"
    fi

  PS1+="\[$bldblk\]]\[$txtrst\]"

  ### The return code section
  PS1+="\[$bldblk\][\[$txtrst\]"

    if [[ $rc == 0 ]]; then
      PS1+="\[$bldgrn\]:)\[$bldwht\] $rc\[$txtrst\]"
    else
      PS1+="\[$bldred\]:(\[$bldred\] $rc\[$txtrst\]"
    fi

  PS1+="\[$bldblk\]]\[$txtrst\]"

  ### The path section
  PS1+="\[$bldblk\][\[$txtrst\]"
    PS1+="\[$bldblu\]\w\[$txtrst\]"
  PS1+="\[$bldblk\]]\[$txtrst\]"

  ### The git branch section
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git_branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)"

    PS1+="\[$bldblk\][\[$txtrst\]"
      PS1+="\[$bldpur\]$git_branch\[$txtrst\]"
    PS1+="\[$bldblk\]]\[$txtrst\]"
  fi

  ### Split to line two
  PS1+="\n"

  ### The timestamp section
  PS1+="\[$bldblk\][\[$txtrst\]"
    PS1+="\[$bldwht\]\t\[$txtrst\]"
  PS1+="\[$bldblk\]]\[$txtrst\]"

  ### Prompt marker
  if [[ $EUID == 0 ]]; then
    PS1+="\[$txtred\]\\$ \[$txtrst\]"
  else
    PS1+="\[$txtwht\]\\$ \[$txtrst\]"
  fi
}

PROMPT_COMMAND=''

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
