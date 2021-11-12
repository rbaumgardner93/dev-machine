#!/usr/bin/env bash

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
echo "\nTask 5: stow directories in dotfiles...\n"
stow brew git kitty nvim tmux zsh

# Install .oh-my-zsh
echo "\nTask 6: Installing Oh My ZSH...\n"
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh

# Source .zshrc
source ~/.zshrc

# Install LTS node version
echo "\nTask 7: Installing LTS version of node...\n"
nvm install --lts && nvm use --lts

# Install node packages
echo "\nTask 8: Installing packages with NPM...\n"
npm i -g yarn eslint typescript-language-server typescript

# Install nvim and lua
echo "\nTask 9: Installing nvim and lua...\n"
brew install --HEAD nvim && brew install --HEAD luajit

# Install vim-plug
echo "\nTask 10: Installing vim-plug...\n"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugins
echo "\nTask 11: Installing vim plugins...\n"
nvim --headless +PlugInstall +qall

