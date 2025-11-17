function flatpinfo -d "Show used space by flatpak"
    for x in $(flatpak list $argv[1] | cut -f2,3,4 | sed "s/\t/\//g" | sed -e "s|/.*/|//|")
        echo "$x $(math $(flatpak info -s $x) / 1000000000) Gb"
    end | sort -k 2h
end
