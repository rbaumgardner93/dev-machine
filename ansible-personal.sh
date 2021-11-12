#!/usr/bin/env bash

# Install Homebrew, if not already installed
which brew > /dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install Ansible, if not already installed
which ansible > /dev/null || brew install ansible

# Provision machine
ansible-pull -U https://github.com/rbaumgardner93/dev-machine.git personal.yml
