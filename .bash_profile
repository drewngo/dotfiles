export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Library/PostgreSQL/18/bin:$PATH"

alias lr='ls -lr'

parse_git_branch() {
    local branch
    if branch=$(git symbolic-ref --short HEAD 2>/dev/null); then
        echo "@$branch"
    elif branch=$(git rev-parse --short HEAD 2>/dev/null); then
        echo "@$branch" # Handles detached HEAD states
    else
        echo "@---"
    fi
}

PS1='[\u@\h \W$(parse_git_branch)]\$ '

