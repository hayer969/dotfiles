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
zoxide init fish | source
#neofetch

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /home/Applications/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

abbr -a -- gwr git\ worktree\ remove\ \(git\ worktree\ list\ --porcelain\ \|\ grep\ worktree\ \|\ fzf\ \|\ cut\ -d\'\ \'\ -f2-\) 
abbr -a -- gwc git\ worktree\ add\ --guess-remote\ \(string\ trim\ \(git\ branch\ -a\ \|\ fzf\ \|\ rev\ \|\ cut\ -d\'/\'\ -f1\ \|\ rev\)\) 
abbr -a -- gtree 'git ls-tree --name-only -r HEAD' 
abbr -a -- cdhorig cdh 
abbr -a -- lf lfcd 
abbr -a -- fn 'find ./ -iname' 
abbr -a -- gp 'git pull' 
abbr -a -- lg lazygit 
abbr -a -- grev 'git rev-list --count HEAD' 
abbr -a -- gbc git\ checkout\ \(string\ trim\ \(git\ branch\ -a\ \|\ fzf\ \|\ rev\ \|\ cut\ -d\'/\'\ -f1\ \|\ rev\)\) 
abbr -a -- file 'nautilus (pwd) &; disown' 
abbr -a -- cat bat 
abbr -a -- gwl 'git worktree list' 
abbr -a -- duf du\ -hsc\ \(ls\ -l\ \|\ fzf\ \|\ rev\ \|\ cut\ -d\'\ \'\ -f1\ \|\ rev\) 
abbr -a -- gsu 'git status -uno' 
abbr -a -- c clear 
abbr -a -- hsf 'commandline (history | fzf)' 
abbr -a -- ga 'git add' 
abbr -a -- gcom 'git commit -m' 
abbr -a -- gaf git\ add\ \(string\ trim\ \(git\ status\ -s\ \|\ fzf\ --preview=\"bat\ --color=always\ \{2..\}\"\)\ \|\ cut\ -d\'\ \'\ -f2-\) 
abbr -a -- gwa 'git worktree add' 
abbr -a -- ls1 'ls -1F'
abbr -a -- gl 'git log --graph --pretty=medium --name-status' 
abbr -a -- term 'alacritty -e fish&; disown' 
abbr -a -- vi nvim 
abbr -a -- vim nvim 
abbr -a -- gs 'git show' 
abbr -a -- cdh cd\ \(string\ trim\ \(dirh\ \|\ cut\ -f2-\ -d\'\)\'\ \|\ sort\ -u\ \|\ fzf\)\) 
abbr -a -- gc 'git checkout' 
abbr -a -- gad git\ add\ \(string\ trim\ \(git\ status\ -suno\ \|\ fzf\ --preview=\"git\ diff\ \{2..\}\ \|\ bat\ --color=always\"\)\ \|\ cut\ -d\'\ \'\ -f2-\) 
abbr -a -- cdf 'cd (fd --type d --no-ignore-vcs --follow --exclude .git --hidden ".*" . | fzf)'
