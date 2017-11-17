#このレポジトリのファイルをシンボリックリンクにする
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/zshrc ~/.zshrc

#NeoBundleのための環境構築
mkdir -p ~/.vim/bundle

mkdir -p ~/.vim/colors

git config --global user.email "river@ht.sfc.keio.ac.jp"
git config --global user.name "Yutaro Hayakawa"

cd ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim

#vimカラースキームのための環境構築
cd ~/.vim/colors
git clone https://github.com/tomasr/molokai.git
cp molokai/colors/molokai.vim .

#zshrcのための環境構築
git clone https://github.com/seebi/dircolors-solarized.git ~/.dircolors-solarized &&
ln -s ~/.dircolors-solarized/dircolors.256dark ~/.dircolors &&
source ~/.zshrc

sudo usermod -s `which zsh` `whoami`
