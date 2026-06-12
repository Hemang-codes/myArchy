if status is-interactive
    # Commands to run in interactive sessions can go here

    # Disable the default welcome greeting
    set -g fish_greeting ""
    neofetch
    # Clear individual theme overrides to keep things clean
    # (Optional: customize via 'fish_config theme' instead)
end

# Abbreviations (More powerful than aliases; expands inline as you type)
abbr -a gco git checkout
abbr -a gs git status
abbr -a ll exa -l -g --icons # Requires 'exa' or 'eza' installed

# Standard Aliases
alias grep "grep --color=auto"
alias c clear

# Set default editor
set -gx EDITOR nvim
