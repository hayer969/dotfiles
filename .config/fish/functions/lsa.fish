function lsa
    if command -q broot
        br -hdps -c :pt $argv
    else
        command ls -la $argv
    end
end
