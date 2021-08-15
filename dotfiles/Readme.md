# To install on your machine

    cd ~
    git clone --bare https://github.com/hayer969/dotfiles.git
    mv ./dotfiles.git ./dotfiles
    alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
    ### Next command may change your entire files and settings, be sure you are ready
    config checkout .
    ### And just in case
    config pull
