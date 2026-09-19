alias ll="ls -la --color=auto"
alias pacup="sudo pacman -Syu"
alias ..="cd .."
fish_add_path /home/user/.local/bin
fish_add_path /opt/cuda/bin
set -gx EDITOR nvim
set -gx BROWSER firefox
function fish_greeting
    neofetch
end
