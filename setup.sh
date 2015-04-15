#このレポジトリのファイルをコピー
cp vimrc ~/.vimrc
cp zshrc ~/.zshrc

#NeoBundleのための環境構築
if [-e ~/.vim/bundle]; then
    mkdir -p ~/.vim/bundle
fi

if [-e ~/.vim/colors] then
    mkdir -p ~/.vim/colors
fi

if [-e ~/.vim/bundle/neobundle]; then
    cd ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim
fi

#vimカラースキームのための環境構築
if [-e ~/.vim/colors/molokai]; then
    cd ~/.vim/colors
    git clone https://github.com/tomasr/molokai.git
    cp molokai/colors/molokai.vim .
fi

#zshrcのための環境構築
if [-e ~/.zshrc]; then
    git clone https://github.com/seebi/dircolors-solarized.git ~/dircolors-solarized &&
    ln -s ~/dircolors-solarized/dircolors.256dark ~/.dircolors &&
    source ~/.zshrc
else
    echo "~/.zshrc doesn't exists!"
fi

