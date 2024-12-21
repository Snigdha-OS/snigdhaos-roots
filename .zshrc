# Lines configured by zsh-newuser-install
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='┌──[%F{red}${USER}%f➜ %F{green}$(get_ip_address)%F{red}${vcs_info_msg_0_}%f] %F{yellow}%t%f
└──╼[%F{green}SNIGDHA OS%]] %F{red}$(pwd)%f 
 %F{red}$ Command: %f'


get_ip_address() {
    ip -4 addr show | grep -v '127.0.0.1' | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1
}

alias ls='ls -l --color=auto'

# Set default aliases
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
alias rs="sudo pacman -Rs"
alias s="sudo pacman -S"
alias sy="sudo pacman -Syy"
alias syyu="sudo pacman -Syyu"
alias lck="sudo rm /var/lib/pacman/db.lck"
alias vm="sudo systemctl enable --now vmtoolsd.service"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias ys="yay -S"
alias pas="paru -S"
alias wget="wget -c"
alias ..="cd .."
alias home="cd ~"
alias docs="cd ~/Documents"
alias dl="cd ~/Downloads"
alias music="cd ~/Music"
alias pics="cd ~/Pictures"
alias vids="cd ~/Videos"
alias desk="cd ~/Desktop"

# Enhanced file manipulation aliases
alias rm="rm -i"           # Confirm before removing files
alias mv="mv -i"           # Confirm before overwriting files
alias cp="cp -i"           # Confirm before overwriting files
alias touch="touch -c"     # Don't create a new file if it already exists
alias du="du -h --max-depth=1"  # Human-readable sizes, limit depth
alias df="df -h"           # Human-readable disk usage
alias find="find . -type f" # Find files only (not directories)

# Git Aliases
alias gs="git status"           # Shortcut for git status
alias ga="git add"              # Shortcut for git add
alias gaa="git add --all"       # Shortcut for git add all
alias gc="git commit"           # Shortcut for git commit
alias gca="git commit --amend" # Shortcut for amend commit
alias gcm="git commit -m"       # Commit with a message
alias gco="git checkout"        # Shortcut for git checkout
alias gbr="git branch"          # Shortcut for git branch
alias gb="git branch"           # Alias for listing branches
alias gl="git log"              # Shortcut for git log
alias glg="git log --oneline --graph --all" # Shortcut for git log with graph
alias gst="git stash"           # Shortcut for git stash
alias gpo="git push origin"     # Shortcut for pushing to origin
alias gpl="git pull"            # Shortcut for git pull
alias gup="git pull --rebase"   # Shortcut for git pull --rebase
alias gd="git diff"             # Shortcut for git diff
alias gds="git diff --staged"   # Shortcut for git diff staged changes
alias gls="git ls-files"        # List files tracked by git
alias gcl="git clone"           # Shortcut for git clone
alias gtag="git tag"            # Shortcut for git tag

