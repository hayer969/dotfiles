function tree
    if command -q broot
        br -H -c :pt $argv
    else
        command tree $argv
    end
end
