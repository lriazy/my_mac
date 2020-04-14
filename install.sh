read -p 'Enter the name for this computer (Return to skip): ' macname

if [ ! $macname == "" ]; then
  sudo scutil --set ComputerName $macname
  sudo scutil --set LocalHostName $macname
  sudo scutil --set HostName $macname
fi

if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating an SSH key for you..."
  ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 4096 -C "jpslav@gmail.com"

  # Haven't cloned the git repo yet so just curl it down
  curl https://raw.githubusercontent.com/jpslav/my_mac/master/dotfiles/ssh_config --output ~/.ssh/config

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
  sublime-merge
  zoomus
  microsoft-office
  adobe-creative-cloud
  slack
  evernote
  docker
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cask install https://raw.githubusercontent.com/Homebrew/homebrew-cask/6a96e5ea44803e52a43c0c89242390f75d1581ab/Casks/kdiff3.rb

echo "Installing the AWS CLI v2..."
cd /tmp
wget https://awscli.amazonaws.com/AWSCLIV2.pkg
open AWSCLIV2.pkg
cd ~

echo "Installing rbenv..."
~/.my_mac/install_ruby.sh

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

brew cleanup

# echo "Please setup and sync Dropbox, and then run this script again."
# read -p "Press [Enter] key after this..."

echo "Setting some Mac settings..."
~/.my_mac/set_preferences.sh

echo "Setting terminal theme..."
~/.my_mac/set_terminal_theme.sh

# # ###############################################################################
# # # Sublime Text                                                                #
# # ###############################################################################

# # # Install Sublime Text settings
# cp ~/.my_mac/dotfiles/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

echo "Setting up Sublime..."
~/.my_mac/sublime/install.sh

# Open extensions for easy install
open -a "Google Chrome" https://chrome.google.com/webstore/search/lastpass
open -a "Google Chrome" https://chrome.google.com/webstore/search/%22the%20great%20suspender%22

# Set reminders for other things to do
reminders=(
  "Add Lastpass extension"
  "Setup Dropbox"
  "Download Photos"
  "Setup Creative Cloud"
  "Log in to MS Office"
  "Add Sublime license"
  "Clean up dock and pin useful apps"
  "Clean finder: hide tags, etc"
  "Add Gmail contacts (add account)"
  "Login to Slack"
  "Login to Harvest"
  "Set desktop backgrounds to cycle"
)

for reminder in "${reminders[@]}"
do
   ~/.my_mac/utilities/add_reminder "$reminder"
done

open -a "Reminders"

echo "Done!"

echo "About to kill terminal so that its settings take hold... pausing for 10 seconds..."
sleep 10
killall Terminal
