#set -x PATH $PATH
#For Alacritty title bar working properly
#set WAYLAND_DISPLAY alacritty
#For VAAPI support
set -x LIBVA_DRIVER_NAME radeonsi

#For case insensitive search in less
set -x LESS "-RFi"

#Path to ripgrep configuration file 
set -x RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc

if command -q nvim
    set -x EDITOR /usr/bin/nvim
    abbr -a -- vi nvim 
    abbr -a -- vim nvim 
end
set -x LANG en_US.UTF-8
set -g fish_prompt_pwd_dir_length 0
set -g fish_color_command 0087ff
set -g fish_color_autosuggestion 9c9c9c

# "bat" as manpager
if command -q bat
    set -x BAT_THEME "Coldark-Dark"
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
    abbr -a -- cat bat 
end
# Add local/bin to Path, some apps installed there
set -x PATH "/home/hayer/.local/bin:$PATH"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
if command -q starship
    starship init fish | source
end
if command -q zoxide
    zoxide init fish | source
end
#fastfetch

if command -q fzf
    set -x FZF_DEFAULT_OPTS "--multi --preview-window=wrap"
    abbr -a -- cdhorig cdh 
    abbr -a -- cdh cd\ \(string\ trim\ \(dirh\ \|\ cut\ -f2-\ -d\'\)\'\ \|\ sort\ -u\ \|\ fzf\)\) 
    if command -q fd
        abbr -a -- cdf 'cd (fd --type d --no-ignore-vcs --follow --exclude .git ".*" . | fzf)'
        abbr -a -- cdfh 'cd (fd --type d --no-ignore-vcs --follow --exclude .git --hidden ".*" . | fzf)'
    end
    abbr -a -- duf du\ -hsc\ \(ls\ -l\ \|\ fzf\ \|\ rev\ \|\ cut\ -d\'\ \'\ -f1\ \|\ rev\) 
    abbr -a -- hsf 'commandline (history | fzf)' 
    abbr -a -- gwr git\ worktree\ remove\ \(git\ worktree\ list\ --porcelain\ \|\ grep\ worktree\ \|\ fzf\ \|\ cut\ -d\'\ \'\ -f2-\) 
    abbr -a -- gwc git\ worktree\ add\ --guess-remote\ \(string\ trim\ \(git\ branch\ -a\ \|\ fzf\ \|\ rev\ \|\ cut\ -d\'/\'\ -f1\ \|\ rev\)\) 
    abbr -a -- gbc git\ checkout\ \(string\ trim\ \(git\ branch\ -a\ \|\ fzf\ \|\ rev\ \|\ cut\ -d\'/\'\ -f1\ \|\ rev\)\) 
    if command -q bat
        abbr -a -- gaf git\ add\ \(string\ trim\ \(git\ status\ -s\ \|\ fzf\ --preview=\"bat\ --color=always\ \{2..\}\"\)\ \|\ cut\ -d\'\ \'\ -f2-\) 
        abbr -a -- gad git\ add\ \(string\ trim\ \(git\ status\ -suno\ \|\ fzf\ --preview=\"git\ diff\ \{2..\}\ \|\ bat\ --color=always\"\)\ \|\ cut\ -d\'\ \'\ -f2-\) 
    end
end
abbr -a -- gwl 'git worktree list' 
abbr -a -- gwa 'git worktree add' 
abbr -a -- gsu 'git status -uno' 
abbr -a -- gp 'git pull' 
abbr -a -- ga 'git add' 
abbr -a -- gl 'git log --graph --pretty=medium --name-status' 
abbr -a -- gcom 'git commit -m' 
abbr -a -- gtree 'git ls-tree --name-only -r HEAD' 
abbr -a -- grev 'git rev-list --count HEAD' 
abbr -a -- gs 'git show' 
abbr -a -- gc 'git checkout' 
if command -q lazygit
    abbr -a -- lg lazygit 
end
abbr -a -- fn 'find ./ -iname' 
abbr -a -- file 'nautilus (pwd) &; disown' 
abbr -a -- c clear 
abbr -a -- ls1 'ls -1F'
abbr -a -- term 'alacritty -e fish&; disown' 

# Check if run inside a container
set TOOLBOX_NAME ""
if test -f "/run/.containerenv"
    set TOOLBOX_NAME $(sed -nr 's/^name="(.*)"$/\1/p' /run/.containerenv)
    if test "$TOOLBOX_NAME" = "dev"
        alias alacritty='flatpak-spawn --host alacritty'
        alias fastfetch='flatpak-spawn --host fastfetch'
        alias btrfs='flatpak-spawn --host btrfs'
        alias rpm-ostree='flatpak-spawn --host rpm-ostree'
        alias firefox='flatpak-spawn --host firefox'
    end
end
