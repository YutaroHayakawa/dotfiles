#NeoBundleのための環境構築
if [-e ~/.vim/bundle]; then
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
else
    echo "~/.vim/bundle doesn't exist! I will make it!"
    mkdir -p ~/.vim/bundle
    git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
fi

#カラースキームのための環境構築
if [-e ~/.vim/colors]; then
    cd ~/.vim/colors
    git clone https://github.com/tomasr/molokai.git
    cp molokai/colors/molokai.vim .
else
    echo "~/.vim/colors doesn't exist! I will make it!"
    mkdir -p ~/.vim/colors
    cd ~/.vim/colors
    git clone https://github.com/tomasr/molokai.git
    cp molokai/colors/molokai.vim .
fi
