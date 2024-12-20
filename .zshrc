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

