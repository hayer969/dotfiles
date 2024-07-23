function tree
    if type -q br
        br -H -c :pt $argv
    else
        command tree $argv
    end
end
