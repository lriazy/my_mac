
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

PROMPT_SCRIPT=~/bin/prompt.pl
export PS1='$( [ -f '"$PROMPT_SCRIPT"' ] && echo $( '"$PROMPT_SCRIPT"' ) || echo "\e[1;37m[\u@\h \W]\$ \e[0m" )'

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -f $DIR/.bash_aliases ]; then
    . $DIR/.bash_aliases
fi

export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
