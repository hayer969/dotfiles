function rgf
    if command -q rg; and command -q fzf; and command -q nvim; and command -q bat
        set -l list (
            rg --no-heading \
               # --color=always \
               --line-number $argv | \
               fzf --delimiter : \
                   --tac \
                   --preview 'bat \
                              --style=full \
                              --color=always \
                              --highlight-line {2} \
                              --line-range {2}:-5 \
                              --line-range {2}: {1}' | \
               cut -d: -f1,2 | \
               sed 's/:/:+/'
        )
        set -l first (echo $list[1] | string split :)
        set --erase list[1]
        set -l list2
        for el in $list
            set --append list2 (echo $el | sed 's/:.*//')
        end
        if test -n $first[1]
            nvim $first $list2
        end
    else
        echo "Please install rg, fzf, nvim, bat"
    end
end
