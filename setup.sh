#!/bin/sh

# Create symlinks for rc files
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/zshrc ~/.zshrc

# Install vim color scheme
mkdir -p ~/.vim/colors
cd ~/.vim/colors
git clone https://github.com/phanviet/vim-monokai-pro
cp vim-monokai-pro/colors/monokai_pro.vim .

# Install Dein.vim
cd ~/.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > dein_installer.sh
sh ./dein_installer.sh ~/.cache/dein

# Change the default shell
kernel=`uname -s`
if [ $kernel = "Darwin" ]; then
  chsh -s `which zsh`
elif [ $kernel = "Linux" ]; then
  sudo usermod -s `which zsh` `whoami`
else
  echo "Unknown kernel name $kernel"
  exit 1
fi

# Install zsh color scheme
git clone https://github.com/seebi/dircolors-solarized.git ~/.dircolors-solarized ||
  cd ~/.dircolors-solarized && git pull

ln -sfn ~/.dircolors-solarized/dircolors.256dark ~/.dircolors

source ~/.zshrc
