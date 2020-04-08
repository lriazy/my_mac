#!/usr/bin/env bash

dotfiles=(.gitconfig .gitignore .gitignore_global .irbrc)

for dotfile in "${dotfiles[@]}"
do
   ln -nfs ~/.my_mac/dotfiles/$dotfile ~/$dotfile
done

if [ -f ~/.bashrc ]
then
	echo "Bash files already exist, skipping"
else
	echo 'if [ -f ~/.my_mac/dotfiles/.bashrc ]; then . ~/.my_mac/dotfiles/.bashrc; fi' > ~/.bashrc
	echo "if [ -f ~/.bashrc ]; then . ~/.bashrc; fi" > ~/.bash_profile 
fi