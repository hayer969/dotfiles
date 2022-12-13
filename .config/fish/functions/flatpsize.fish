# Calculate overall used space by flatpak
function flatpsize -d "Calculate overall used space by flatpak"
    echo (math (for x in (flatpak list | cut -f2,3,4 | sed "s/\t/\//g" | sed -e "s|/.*/|//|")
              echo +(flatpak info -s $x)
          end | math) / 1000000000) Gb
end
