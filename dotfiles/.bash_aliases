alias up='cd ..'
alias ss='source ~/.bashrc'

alias ll="ls -l -GF"
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

alias gitdt="git difftool --no-prompt -t kdiff3"
alias gitdtc="gitdt --cached"
alias gitmr="git merge --no-commit --no-ff"
alias gitmt="git mergetool --no-prompt -t kdiff3"

alias be="bundle exec"

alias startpg='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'

alias rmorig='find . -name "*.orig" -delete'

alias uncommit='git reset --soft HEAD^'

alias xcode='open -a Xcode'
