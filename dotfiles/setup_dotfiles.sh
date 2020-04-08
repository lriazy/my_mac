#!/usr/bin/env bash

dotfiles=(.gitconfig .gitignore .gitignore_global .irbrc)

for dotfile in "${dotfiles[@]}"
do
   ln -nfs $dotfile ~/$dotfile
done

echo 'if [ -f ~/.my_mac/dotfiles/.bashrc ] then; . ~/.my_mac/dotfiles/.bashrc; fi' | cat - ~/.bashrc > temp && move temp ~/.bashrc
