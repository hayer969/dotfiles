#set -x PATH $PATH
#For Alacritty title bar working properly
#set WAYLAND_DISPLAY alacritty
#For VAAPI support
set -x LIBVA_DRIVER_NAME radeonsi

#For case insensitive search in less
set -x LESS "-RFi"

#Path to ripgrep configuration file 
set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc

set -x EDITOR /usr/bin/nvim
set -x LANG en_US.UTF-8
set -x FZF_DEFAULT_OPTS "--multi --preview-window=wrap"
set -g fish_prompt_pwd_dir_length 0
set -g fish_color_command 0087ff
set -g fish_color_autosuggestion 9c9c9c

# "bat" as manpager
set -x BAT_THEME "Coldark-Dark"
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# Add poetry to Path
set -x PATH "/home/hayer/.local/bin:$PATH"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
starship init fish | source
#neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /home/Applications/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

