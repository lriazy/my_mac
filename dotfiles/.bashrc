
# The below export can be seen as having two aspects. The first is the
# position. There are a total of 11 positions, with a foreground and a
# background being listed in that order, for each position, resulting in
# 22 total letters. The following represents each position, in sequence:
#
# Directory
# Symbolic link
# Socket
# Pipe
# Executable
# Special block
# Special character
# Executable w/ setuid set
# Executable w/ setgid set
# Directory that is writable to others w/ sticky bit
# Directory that is writable to others w/out sticky bit
#
# Next, consider the colors that are used. These include:
#
# a black
# b red
# c green
# d brown
# e blue
# f magenta
# g cyan
# h light grey
# x default foreground or background

export CLICOLOR=1
export LSCOLORS=ExGxCxDxBxegedabagaced

##
## Set the prompt to be the output of ~/bin/prompt.pl
##

export PS1='$(~/bin/prompt.pl)'

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

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
