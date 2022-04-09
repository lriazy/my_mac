#!/usr/bin/env bash

dotfiles=(.gitconfig .gitignore .gitignore_global .irbrc)

for dotfile in "${dotfiles[@]}"
do
   ln -nfs ~/.my_mac/dotfiles/$dotfile ~/$dotfile
done

prepend_line_to_file () {
  local line=$1
  local file="${2/\~/$HOME}"
  touch "$file"
  grep -qxF "$line" $file || echo -e "$line\n$(cat $file)" > $file
}

prepend_line_to_file $'if [ -f ~/.my_mac/dotfiles/.bashrc ]; then . ~/.my_mac/dotfiles/.bashrc; fi\n' '~/.bashrc'
prepend_line_to_file $'if [ -f ~/.bashrc ]; then . ~/.bashrc; fi\n' '~/.bash_profile'
