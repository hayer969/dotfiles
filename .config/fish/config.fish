#set -x PATH $PATH

#For case insensitive search in less
set -x LESS "-RFi"

set -x EDITOR /usr/bin/nvim
set -x LANG en_US.UTF-8
set -x FZF_DEFAULT_OPTS "--multi"
set -g fish_prompt_pwd_dir_length 0
set -g theme_newline_cursor yes
set -g theme_display_git_master_branch yes
set -g theme_display_git_ahead_verbose yes
set -g theme_show_exit_status yes
set -g theme_date_timezone Europe/Moscow
set -g theme_date_format "+%a %H:%M:%S"
set -g theme_nerd_fonts yes
set -g bobthefish_color_prompt d3b260
set -g bobthefish_color_path d3b260
set -g fish_color_autosuggestion 9c9c9c

### "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
#neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/hayer/Applications/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

