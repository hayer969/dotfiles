function mpo --description 'Patch MPO virtualization imageTag with kubectl'
    if test (count $argv) -lt 1
        # Retrieve the current imageTag if no argument is provided
        d8 k get mpo virtualization -o jsonpath={.spec.imageTag}\n
    else
        # Store the first argument
        set arg $argv[1]
        # Check if the argument is a number (contains only digits)
        if string match -qr '^[0-9]+$' -- $arg
            # If numeric, prepend "pr" to the argument
            set tag "pr$arg"
        else
            # If non-numeric, use the argument as is
            set tag $arg
        end
        # Patch the imageTag with the resulting tag
        d8 k patch mpo virtualization --type merge -p "{\"spec\":{\"imageTag\":\"$tag\"}}"
    end
end
