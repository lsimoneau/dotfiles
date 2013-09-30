# Git aliases
alias gu='git push origin $(current_branch)'
alias gd='git fetch && git rebase -P origin/$(current_branch)'
alias gff='git fetch && git merge origin/$(current_branch) --ff-only'

function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function current_repository() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo $(git remote -v | cut -d':' -f 2)
}
