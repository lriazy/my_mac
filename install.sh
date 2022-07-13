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
# https://stackoverflow.com/a/3557165
sudo bash -c "grep -qxF '/usr/local/bin/bash' /etc/shells || echo '/usr/local/bin/bash' >> /etc/shells"
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

echo "Installing bin dir..."
~/.my_mac/bin/install.sh

# Apps
apps=(
  cleanmymac
  dropbox
  firefox
  google-chrome
  steam
  spotify
  zoom
  microsoft-office
  adobe-creative-cloud
  slack
  docker
  anylist
  visual-studio-code
  mimestream
  kdiff3
  authy
  box-drive
  tripmode
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew install --appdir="/Applications" --cask ${apps[@]}

echo "Installing the AWS CLI v2..."
cd /tmp
wget https://awscli.amazonaws.com/AWSCLIV2.pkg
open AWSCLIV2.pkg
cd ~

echo "Installing rbenv..."
~/.my_mac/install_ruby.sh

echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

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
  "Setup Dropbox (turn off do_not_sync)"
  "Download Photos"
  "Setup Creative Cloud"
  "Log in to MS Office"
  "Clean up dock and pin useful apps"
  "Clean finder: hide tags, etc"
  "Add Gmail contacts (add account)"
  "Login to Slack"
  "Set desktop backgrounds to cycle"
  "Install Moom"
  "Install GoodNotes"
  "Enable apple watch to unlock mac"
  "Require password 5 seconds after screensaver"
  "Install 1Password from 1password.com"
  "Add 1Password browser extension"
  "Install Rice Google Calendar app"
)

for reminder in "${reminders[@]}"
do
   ~/.my_mac/utilities/add_reminder "$reminder"
done

open -a "Reminders"

echo "Done!"

read -p 'Press any key to kill terminal so that its settings take hold...: ' maybeDontNeedThis
killall Terminal
