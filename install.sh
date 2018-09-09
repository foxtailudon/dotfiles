T_FILES=(.tmux.conf .vim .viminfo .vimrc .zprofile .zsh_history .zshenv .zshrc)

usage_exit(){
    echo "Usage $0 [-m MacOS] [-u Ubuntu]" 1>&2
    exit 1
}

create_directory(){
    for file in ${DOT_FILES[@]}
    do 
        ln -s $HOME/dotfiles/$file $HOME/$file
    done
}

vim_install(){
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o /tmp/dein_installer.sh
    sh /tmp/dein_installer.sh ~/dotfiles/.vim/bundle
    rm /tmp/dein_installer.sh
    git clone --rcursive https://github.com/davidhalter/jedi-vim.git ~/dotfiles/.vim/bundle/jedi-vim
}


while getopts mulh OPT
do
    case $OPT in
        m) 
            brew install tmux zsh 
            pip3 install --upgrade pip
            pip3 install powerline-status
            create_directory
            vim_install
            ;;
        u)
            apt install tmux zsh
            pip3 install --upgrade pip
            pip3 install --user powerline-status
            create_directory
            vim_install
            ;;
        h) 
            usage_exit
            ;;
        \?)
            usage_exit
            ;;
    esac
done
