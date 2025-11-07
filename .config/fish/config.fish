#set -gx PATH $PATH
#For Alacritty title bar working properly
#set WAYLAND_DISPLAY alacritty
#For VAAPI support
# set -x LIBVA_DRIVER_NAME radeonsi

#For case insensitive search in less
set -gx LESS "-RFi"

#Path to ripgrep configuration file
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgreprc

if command -q nvim
    set -x EDITOR /snap/bin/nvim
    abbr -a -- vi nvim 
    abbr -a -- vim nvim 
end
set -gx LANG en_US.UTF-8
set -g fish_prompt_pwd_dir_length 0
set -g fish_color_command 0087ff
set -g fish_color_autosuggestion 9c9c9c

# Set the cursor shapes for the different vi modes.
set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block blink
set fish_vi_force_cursor 1

# "bat" as manpager and abbr for bat
if command -q bat
    set -gx BAT_THEME "Coldark-Dark"
    set -gx MANROFFOPT "-c"
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

    abbr -a -- cat bat -pp
    abbr -a -- baty "bat -lyaml"
end

set -gx GOROOT "/usr/local/go"
set -gx GOPATH "$HOME/go"
# Add local/bin to Path, some apps installed there
set -gx PATH "$HOME/.local/bin:$GOPATH/bin:$GOROOT/bin:$PATH:$HOME/.krew/bin"

alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
if command -q starship
    starship init fish | source
end
if command -q zoxide
    zoxide init fish | source
end

#fastfetch

if command -q fzf
    set -gx FZF_DEFAULT_OPTS "--multi --preview-window=wrap"
    abbr -a -- cdhorig cdh
    abbr -a -- cdh "cd (string trim (dirh | cut -f2- -d')' | sort -u | fzf))"
    if command -q fd
        abbr -a -- cdf 'cd (fd --type d --no-ignore-vcs --follow --exclude .git ".*" . | fzf)'
        abbr -a -- cdfh 'cd (fd --type d --no-ignore-vcs --follow --exclude .git --hidden ".*" . | fzf)'
    end
    abbr -a -- duf "du -hsc (ls -l | fzf | rev | cut -d' ' -f1 | rev)"
    abbr -a -- hsf 'commandline (history | fzf)'
    abbr -a -- gwr "git worktree remove (git worktree list --porcelain | grep worktree | fzf | cut -d' ' -f2-)"
    abbr -a -- gbd 'git branch -d (string trim (git branch -a | fzf))'
    abbr -a -- gbrd "git push origin -d (string trim (git branch -a | fzf | rev | cut -d'/' -f1 | rev))"
    abbr -a -- gcb 'git checkout $(git branch -a | fzf | string replace "remotes/origin/" "" | string trim)'
    abbr -a -- gwa 'git worktree add ../(basename (pwd))_worktrees/(set bn (string trim (git branch -a | fzf | string replace "remotes/origin/" "")); echo $bn | string replace -a "/" ".") $bn'
    abbr -a -- gdf "git difftool -y --tool=nvimdiff -- (git status -suno | fzf | string trim | cut -d' ' -f2)"
    abbr -a -- flatrun 'flatpak run $(flatpak list --app | fzf | cut -d\t -f2)'
    if command -q bat
        abbr -a -- gaf "git add (string trim (git status -s | fzf --preview=\"bat --color=always {2..}\") | cut -d' ' -f2-)"
        abbr -a -- gad "git add (string trim (git status -suno | fzf --preview=\"git diff {2..} | bat --color=always\") | cut -d' ' -f2-)"
    end
end
abbr -a -- gws "cd (git worktree list | fzf | cut -d' ' -f1)"
abbr -a -- gsu 'git status -uno'
abbr -a -- gp 'git pull --rebase'
abbr -a -- ga 'git add'
abbr -a -- gau 'git add -u'
abbr -a -- gl 'git log --graph --pretty=medium --name-status'
abbr -a -- gcom 'git commit -m "'
abbr -a -- gcoms 'git commit --signoff -m "'
abbr -a -- gtree 'git ls-tree --name-only -r HEAD'
abbr -a -- grev 'git rev-list --count HEAD'
abbr -a -- gs 'git show'
abbr -a -- gb 'git branch'
abbr -a -- gc 'git checkout'
if command -q lazygit
    abbr -a -- lg lazygit
end
if command -q zellij
    abbr -a -- zlf 'zellij --layout (ls ~/.config/zellij/*layout.kdl | fzf)'
    abbr -a -- zll "zellij a -f (zellij ls -n | tail -n 1 | cut -d' ' -f1)"
end
abbr -a -- fn 'find ./ -iname'
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
        alias flatpak='flatpak-spawn --host flatpak'
        alias firefox='flatpak-spawn --host firefox'
        alias btop='flatpak-spawn --host btop'
        alias podman='flatpak-spawn --host podman'
        alias nautilus='flatpak-spawn --host nautilus'
        alias file='flatpak-spawn --host command nautilus (pwd)'
    end
else
    abbr -a -- file 'nautilus (pwd) &; disown'
end

abbr -a -- glcopy 'git rev-parse HEAD | xsel -b'

# Ask pass for ssh
if status --is-interactive
    set -lx SHELL fish
    keychain --eval --quiet | source
end

/usr/bin/keychain --inherit any --confirm $HOME/.ssh/dmitry.prytkov-thinkpad

# set KUBECONFIG environment variable
set KUBECONF_DIR $HOME/.kubeconfigs
set CLUSTER_MERGE "$KUBECONF_DIR/cluster-merge"
set TMP_KUBECONFIG (find $KUBECONF_DIR -name kubeconfig -printf "%p:")

set -gx KUBECONFIG "$CLUSTER_MERGE:$TMP_KUBECONFIG"

# alias d8="trdl exec d8 0 ea -- $argv"
ln -sf (trdl bin-path d8 0 ea)/d8 $HOME/.local/bin/d8
ln -sf (trdl bin-path flint 2 stable)/flint $HOME/.local/bin/flint
source (flint completion --shell=fish | psub)
source $HOME/.config/fish/completions/d8v.fish
# Alias for kubectl
# abbr -a -- ku 'kubectl'
abbr -a -- ku 'd8 k'
abbr -a -- dqui 'watch "d8 k -n d8-system exec svc/deckhouse-leader -- deckhouse-controller queue list"'
abbr -a -- dvirt 'd8 k get internalvirtualizationkubevirts.internal.virtualization.deckhouse.io -n d8-virtualization config -ojsonpath="{.status.conditions[?(@.type==\"Available\")]}{\"\n\"}" -w'
abbr -a -- ded 'd8 k logs -n d8-virtualization deployments/virtualization-controller | grep -i edition'
# abbr -a -- dedpr 'd8 k get mpo -oyaml | yq \'.items[] | select(.metadata.labels.module == "virtualization") | .spec.imageTag\''
abbr -a -- dedpr 'd8 k get mpo virtualization -oyaml | yq \'.spec.imageTag\''
abbr -a -- dedvc 'watch "d8 k get pods -n d8-virtualization --selector=app=virtualization-controller"'
abbr -a -- dedup 'helm list -n d8-system | grep virtualization'
abbr -a -- dead8 'd8 k get pod -A --sort-by="{.metadata.creationTimestamp}" --no-headers | tac | grep -Ev "Running|Completed"'
abbr -a -- virtlog 'd8 k -n d8-virtualization logs -l app=virtualization-controller | rg "panic|error"'
abbr -a -- dcklog 'd8 k -n d8-system logs -l app=deckhouse -c deckhouse | jq "select(.level==\"error\")"'
abbr -a -- kuf 'd8 k apply -f'
abbr -a -- kuk 'd8 k apply -k'
alias linstor='kubectl -n d8-sds-replicated-volume exec -ti deploy/linstor-controller -- linstor'

# Tunnel and github ssh key
if status --is-interactive
    # ssh-add ~/.ssh/dmitry.prytkov-thinkpad-github
    set -l tunnel_commands \
    "ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.d8-virt-master-0 -L 127.0.0.1:2000:127.0.0.1:6445" \
    "ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.d8-virt-hypert-test-0 -L 127.0.0.1:2002:127.0.0.1:6445"
    # "ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.virtlab-dl-1 -L 127.0.0.1:2007:127.0.0.1:6445"
    #"ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.virtlab-delivery-mi-0 -L 127.0.0.1:2003:127.0.0.1:6445" \
    # "ssh -o ServerAliveInterval=60 -J d.prytkov@dev-rnd.d8-virt-hypert-test-0 -N cloud@10.66.10.106 -i $HOME/kube-manifests/templates/sshkeys/id_ed -L 127.0.0.1:2004:127.0.0.1:6445" \
    # "ssh -o ServerAliveInterval=60 -J d.prytkov@dev-rnd.d8-virt-hypert-test-0 -N cloud@10.66.10.106 -i $HOME/kube-manifests/templates/sshkeys/id_ed -D 1080"
    # "ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.virtlab-rd-0 -L 127.0.0.1:2005:127.0.0.1:6445"
    # "ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.virtlab-pt-0 -L 127.0.0.1:2006:127.0.0.1:6445" \
    # "ssh -o ServerAliveInterval=60 -N d.prytkov@dev-rnd.virtlab-da-0 -L 127.0.0.1:2007:127.0.0.1:6445"

    function get_tunnel_pid
    # Store the tunnel pid in a variable
        ps aux | grep "[ ]$argv[1]" | awk '{print $2}'
        # Check the exit statuses if grep return error
        for s in $pipestatus
            if test $s -ne 0
                return $s
            end
        end
    end

    function get_server_name
    # Get server name for user prompt
        for word in $(string split ' ' $argv[1])
            if string match -q '*@*' -- $word
                echo $word
                break
            end
        end
    end

    for tc in $tunnel_commands
        if not string match -qr '^\d+$' -- $(get_tunnel_pid $tc)
            echo "Set tunnel to $(get_server_name $tc)? (y/n)"
            read user_input -n 1

            # Convert the input to lowercase before comparison
            set -l user_input (string lower $user_input)

            if test "$user_input" = "y"
                # Check if the tunnel_pid is a number (digits only)
                    eval "nohup $tc &> /dev/null &"
                    disown %1
            end
                # See tunnel-kill abbr below
                # set -U TUNNEL_PIDS $TUNNEL_PIDS $last_pid
        end
    end

    # After kill tunnel you need somehow sync var TUNNEL_PIDS
    # And you can kill it by different methods
    # Better don't use this abbr
    # abbr -a -- tunnel-kill 'kill $TUNNEL_PIDS'
end
