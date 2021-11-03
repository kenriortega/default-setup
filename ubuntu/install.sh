#!/bin/bash

# Ask for sudo access at start of script
if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# initial upgrade of system
sudo apt-get update -yy
sudo apt-get upgrade -yy
sudo apt-get dist-upgrade -yy

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# ppa
sudo add-apt-repository -yy ppa:neovim-ppa/stable

# repository keys
## chrome
wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -
sudo apt-get update

# Installations
## Essential
sudo apt-get install -yy neovim
# migrated to neovim. Left for reference
    # sudo apt-get install -yy vim
    # sudo apt-get install -yy vim-gui-common

sudo apt-get install -yy software-properties-common
sudo apt-get install -yy apt-transport-https
sudo apt-get install -yy ca-certificates
sudo apt-get install -yy curl
sudo apt-get install -yy git
sudo apt-get install -yy tmux
sudo apt-get install -yy ctags

## C/CPP Specific
sudo apt-get install -yy build-essential
sudo apt-get install -yy cmake

# install golang
./install_go.sh

# install go binaries
go install github.com/zmb3/gogetdoc
go install golang.org/x/tools/cmd/guru
go install golang.org/x/tools/gopls@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct
go install github.com/rogpeppe/godef
go install github.com/fatih/motion
go install github.com/kisielk/errcheck
go install github.com/go-delve/delve/cmd/dlv
go install github.com/mdempsky/gocode
go install github.com/josharian/impl
go install github.com/golangci/golangci-lint/cmd/golangci-lint
go install github.com/jstemmer/gotags
go install golang.org/x/tools/cmd/gorename
go install golang.org/x/tools/cmd/goimports
go install github.com/stamblerre/gocode
go install github.com/fatih/gomodifytags
go install honnef.co/go/tools/cmd/keyify
go install golang.org/x/lint/golint
go install github.com/koron/iferr
go install github.com/klauspost/asmfmt/cmd/asmfmt
go install github.com/alecthomas/gometalinter

## Desktop Apps
sudo apt-get install -yy google-chrome-stable
sudo snap install telegram-desktop

# git configurations
git config --global user.email "kenriortega@gmail.com"
git config --global user.name "kenriortega"
git config --system core.editor "vim"

# git aliases
git config --global alias.co checkout
git config --global alias.a add
git config --global alias.b branch
git config --global alias.c commit
git config --global alias.l log
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'

# clicking on app in dock minimizes it
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# change ubuntu computer name
hostnamectl set-hostname 'kenridev'

# add dotfiles
git clone --recurse-submodules https://github.com/kenriortega/dotfiles
cd .. && ./install.sh
rm -rf dotfiles