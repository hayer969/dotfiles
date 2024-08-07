function br
    if command -q broot
        set -l cmd_file (mktemp)
        if broot --outcmd $cmd_file $argv
            read --local --null cmd < $cmd_file
            rm -f $cmd_file
            eval $cmd
        else
            set -l code $status
            rm -f $cmd_file
            return $code
        end
    else
        echo "broot doesn't installed"
    end
end
