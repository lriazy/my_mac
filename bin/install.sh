#!/usr/bin/env bash

# For aws-rotate-iam-keys
echo "Installing getopt..."
brew install gnu-getopt
echo "Installing jq..."
brew install jq

# For installing and updating secrets
brew install lastpass-cli

echo "Linking my_mac bin directory"
cd ~
ln -nfs ~/.my_mac/bin ~/bin
