#!/usr/bin/env bash

set -e

# Install Homebrew, if not already installed
echo "\nTask 1: Installing Homebrew if it does not already exist...\n"
which brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install git
echo "\nTask 2: Installing git from brew if not already available\n"
which git > /dev/null || brew install git

# Pull down dotfiles
echo "\nTask 3: Installing dotfiles...\n"
git clone --recurse-submodules -j8 https://github.com/rbaumgardner93/dotfiles.git ~/dotfiles

# Move to dotfiles folder
cd ~/dotfiles

# Install from Brewfile
echo "\nTask 4: Installing from Brewfile...\n"
brew bundle install --file=./brew/Brewfile

# Stow dotfiles
echo "\nTask 5: Stow directories in dotfiles...\n"
stow brew git kitty nvim tmux zsh

echo "\n Task 6: Set up git name and email...\n"
echo What name would you like to use for your git config?
read NAME
echo What email would you like to use for your git config?
read EMAIL
echo -e "[user]\n\tname = $NAME\n\temail = $EMAIL" > ~/.gitconfig.local

# Install .oh-my-zsh
echo "\nTask 7: Verify Oh My ZSH exists or install Oh My ZSH...\n"
OHMYZSH=~/.oh-my-zsh
if [ -d "$OHMYZSH" ]; then
    echo "$OHMYZSH exists."
else
    echo "$OHMYZSH does not exist. Cloning from github."
    git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

# Source .zshrc
source ~/.zshrc

# Install LTS node version
echo "\nTask 8: Installing LTS version of node...\n"
fnm install --lts

# Install node packages
echo "\nTask 9: Installing packages with NPM...\n"
npm-installer

# Install nvim and lua
echo "\nTask 10: Installing nvim and lua...\n"
brew install --HEAD nvim && brew install --HEAD luajit

# Install vim-plug
echo "\nTask 11: Installing vim-plug...\n"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugins
echo "\nTask 12: Installing vim plugins...\n"
nvim --headless +PlugInstall +qall

