function fish_greeting -d "What's up, fish?"
    set_color $bobthefish_color_prompt
    uname -nmsr

    # TODO: `command -q -s` only works on fish 2.5+, so hold off on that for now
    command -s uptime >/dev/null
    and command uptime

    set_color normal
end
