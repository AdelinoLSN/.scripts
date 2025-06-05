alias aliases_git="nvim ~/.scripts/git.sh"

alias glast="git checkout -"

alias gs="git status"

alias gl="git log --oneline --abbrev-commit"

alias gd="git diff"
alias gds="git diff --staged"

gnb() {
    # Checkout the new branch
    git checkout -b "$1";
}

alias ga="git add ."
alias gap="git add -p"

gc() {
    local commit_message="$1";

    if [[ -z $commit_message ]] # If there is no commit message
        then
    	    git commit -m "WIP";
        else
            git commit -m "$commit_message";
    fi
}

alias gca="git commit --amend"

alias gcane="git commit --amend --no-edit"

gri() {
    git rebase -i HEAD~$1
}

alias gp="git push"
alias gpf="git push -f"

alias gundo="git reset HEAD^1"

gpu() {
    git push -u origin "$(git rev-parse --abbrev-ref HEAD)";
}
