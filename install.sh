read -p 'Enter the name for this computer (Return to skip): ' macname

if [ ! $macname == "" ]; then
  sudo scutil --set ComputerName $macname
  sudo scutil --set LocalHostName $macname
  sudo scutil --set HostName $macname
fi

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating an SSH key for you..."
  ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C "lriazy"

  # Haven't cloned the git repo yet so just curl it down
  curl https://raw.githubusercontent.com/lriazy/my_mac/master/dotfiles/ssh_config --output ~/.ssh/config

  ssh-add -K ~/.ssh/id_rsa

  pbcopy < ~/.ssh/id_rsa.pub

  osascript -e 'tell application (path to frontmost application as text) to display dialog "Press OK to open a browser for adding your new ~/.ssh/id_rsa key to Github - it is copied to your clipboard" buttons {"OK"}'

  open "https://github.com/account/ssh"
  read -p "Press [Enter] key after you have added your SSH key to Github..."
fi

echo "Installing xcode-stuff"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/leiliriazy/.bash_profile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating homebrew..."
brew update

echo "Installing zsh... "
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Git..."
brew install git

echo "Git config"
git config --global user.name "LRiazy"
git config --global user.email leili.riazy@gmail.com

echo "Installing other brew stuff..."
brew install wget

echo "Cleaning up brew"
brew cleanup

echo "Cloning my_mac"
cd ~
git clone git@github.com:lriazy/my_mac.git .my_mac

echo "Setting up dotfiles"
cd ~/.my_mac/dotfiles
./setup_dotfiles.sh

# Apps
apps=(
  firefox
  spotify
  microsoft-office
  visual-studio-code
  kdiff3
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew install --appdir="/Applications" --cask ${apps[@]}

echo "Installing python..."
brew install pyenv
pyenv install 3.9.2

echo "installing poetry..."
curl -sSL https://install.python-poetry.org | python3 -

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo "source ~/Library/Application Support/pypoetry/venv/bin/poetry" >> ~/.bashrc

brew cleanup

# echo "Please setup and sync Dropbox, and then run this script again."
# read -p "Press [Enter] key after this..."

echo "Setting some Mac settings..."
~/.my_mac/set_preferences.sh

echo "Setting terminal theme..."
~/.my_mac/set_terminal_theme.sh

# Install secrets
echo "Installing secrets..."
~/.my_mac/install_secrets.rb

# Set reminders for other things to do
reminders=(
  "Install GoodNotes"
  "Enable apple watch to unlock mac"
)

for reminder in "${reminders[@]}"
do
   ~/.my_mac/utilities/add_reminder "$reminder"
done

open -a "Reminders"

echo "Done!"

read -p 'Press any key to kill terminal so that its settings take hold...: ' maybeDontNeedThis
killall Terminal
