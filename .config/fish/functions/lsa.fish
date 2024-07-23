function lsa
    if type -q br
        br -hdps -c :pt $argv
    else
        command ls -la $argv
    end
end
