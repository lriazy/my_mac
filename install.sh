read -p 'Enter the name for this computer (Return to skip): ' macname

if [ ! $macname == "" ]; then
  echo "here"
  sudo scutil --set ComputerName $macname
  sudo scutil --set LocalHostName $macname
  sudo scutil --set HostName $macname
fi

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating an SSH key for you..."
  ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C "jpslav@gmail.com"

  osascript -e 'tell application (path to frontmost application as text) to display dialog "Press OK to open a browser for adding your new ~/.ssh/id_rsa key to Github" buttons {"OK"}'

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
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing latest Bash and setting it as the default shell..."
brew install bash
sudo bash -c "echo '/usr/local/bin/bash' >> /etc/shells"
chsh -s /usr/local/bin/bash

echo "Installing Git..."
brew install git

echo "Git config"
git config --global user.name "JP Slavinsky"
git config --global user.email jpslav@gmail.com

echo "Installing other brew stuff..."
brew install wget

echo "Cleaning up brew"
brew cleanup

echo "Cloning my_mac"
cd ~
git clone git@github.com:jpslav/my_mac.git .my_mac

echo "Setting up dotfiles"
cd ~/.my_mac/dotfiles
./setup_dotfiles.sh

echo "Linking my_mac bin directory"
cd ~
ln -nfs ~/.my_mac/bin ~/bin

# Apps
apps=(
  cleanmymac
  dropbox
  firefox
  google-chrome
  harvest
  steam
  spotify
  sublime-text
  zoomus
  https://raw.githubusercontent.com/Homebrew/homebrew-cask/6a96e5ea44803e52a43c0c89242390f75d1581ab/Casks/kdiff3.rb
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup

echo "Please setup and sync Dropbox, and then run this script again."
read -p "Press [Enter] key after this..."

echo "Restoring setup from Mackup..."
#mackup restore @TODO uncomment

echo "Setting some Mac settings..."
./set_preferences.sh

echo "Setting terminal theme..."
./set_terminal_theme.sh

echo "Done!"

#@TODO install vagrant and sites folder
