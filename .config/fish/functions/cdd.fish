# deep fuzzy cd
function cdd -d "find folder [where start find: root, current or default-home]"
    if command -q broot
        if test "$argv[-1]" != "."; and test "$argv[-1]" != "/"
            cd ~
        else
            if test "$argv[-1]" = "/"
                cd /
            end
            set argv $argv[1..-2]
        end

        for i in $argv
            set path "$path.*$i"
        end
        br -h --only-folders --cmd "rp/$path.*/i:cd"
    else
        echo "broot doesn't installed"
    end
end
