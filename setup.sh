#このレポジトリのファイルをコピー
cp vimrc ~/.vimrc
cp zshrc ~/.zshrc

#NeoBundleのための環境構築
mkdir -p ~/.vim/bundle

mkdir -p ~/.vim/colors

cd ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim

#vimカラースキームのための環境構築
cd ~/.vim/colors
git clone https://github.com/tomasr/molokai.git
cp molokai/colors/molokai.vim .

#zshrcのための環境構築
git clone https://github.com/seebi/dircolors-solarized.git ~/dircolors-solarized &&
ln -s ~/dircolors-solarized/dircolors.256dark ~/.dircolors &&
source ~/.zshrc

