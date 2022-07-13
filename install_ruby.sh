#!/usr/bin/env bash

brew install rbenv

# rbenv init asks us to do the following:
if grep -v "rbenv init" ~/.bash_profile; then
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

read -p 'Enter the Ruby version to install (Return for default of 3.1.2): ' ruby_version

if [ -z "$ruby_version" ]; then
  ruby_version="3.1.2"
fi

rbenv install $ruby_version
rbenv global $ruby_version
