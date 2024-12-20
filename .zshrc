# ~/.zshrc

# Function to append to PATH if not already present
append_path () {
    case ":$PATH:" in
        *:"$1":*) ;;
        *) PATH="${PATH:+$PATH:}$1" ;;
    esac
}

# Add user bin directories to PATH if they exist
append_path "$HOME/bin"
append_path "$HOME/.local/bin"
append_path "$HOME/.bin"   # Append .bin only if directory exists

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

# Enable case-insensitive completion
bindkey -v  # Enables Vi-like keybindings, similar to Bash's completion-ignore-case

# Function for extracting different types of archives
ex () {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1" ;;
            *.tar.gz)    tar xzf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.gz)        gunzip "$1"  ;;
            *.tar)       tar xf "$1"  ;;
            *.tbz2)      tar xjf "$1" ;;
            *.tgz)       tar xzf "$1" ;;
            *.zip)       unzip "$1"   ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"    ;;
            *.deb)       ar x "$1"    ;;
            *.tar.xz)    tar xf "$1"  ;;
            *.tar.zst)   tar xf "$1"  ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Custom PS1 prompt with IP address and conditional formatting based on terminal type
get_ip_address() {
    # Extract non-local IP address
    ip -4 addr show | grep -v '127.0.0.1' | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1
}

# Check if in a terminal session
if [[ $(tty) == */dev/tty* ]]; then
    PS1="%{$fg_bold[red]%}[%n%{$fg[green]%}IP: $(get_ip_address) | %{$fg_bold[red]%}]\n[>]%{$fg_bold[red]%}$(pwd) $ %{$reset_color%}"
else
    PS1="%{$fg_bold[red]%}┌──[I'm %n%{$reset_color%}➜ %{$fg[green]%}Public IP: $(get_ip_address)🔒%{$fg_bold[red]%}]\n└──╼[%{$fg[green]%}SNIGDHA OS%{$fg_bold[red]%}]%{$fg_bold[red]%}$(pwd)\n$ Command: %{$reset_color%}"
fi

# Display system information via neofetch if the flag is not set
if [[ $1 != "no-repeat-flag" && -z $NO_REPETITION ]]; then
    neofetch
fi

# Additional useful aliases
alias cls="clear"                     # Clear the terminal screen
alias h="history"                     # Show command history
alias upg="sudo pacman -Syu"          # Update system
alias restart="sudo reboot"           # Restart system
alias shutdown="sudo shutdown -h now" # Shutdown system
alias halt="sudo shutdown -h now"     # Shutdown system (alternative)
alias lock="i3lock"                   # Lock screen
alias logs="journalctl -xe"           # Show system logs
alias t="tmux"                        # Start tmux session
alias top="htop"                      # Use htop instead of top
alias cpu="lscpu"                     # Display CPU info
alias mem="free -h"                   # Display memory info
alias battery="upower -i $(upower -e | grep 'BAT') | grep 'state\|percentage'" # Battery status

# Navigate the system more efficiently
alias src="cd ~/src"  # Navigate to source code directory
alias code="code ."    # Open VSCode in current directory

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

# npm Aliases
alias ni="npm install"            # Shortcut for npm install
alias nis="npm install --save"     # Install and save the package in dependencies
alias nisdev="npm install --save-dev" # Install and save as dev dependency
alias nup="npm update"             # Update all packages
alias nstart="npm start"           # Start the application (npm start)
alias nrun="npm run"               # Run npm scripts
alias ntest="npm test"             # Run npm tests
alias nls="npm ls"                 # List installed packages
alias nci="npm ci"                 # Clean install (faster than npm install)
alias nfund="npm fund"             # Show funding info for packages
alias npublish="npm publish"       # Publish package to npm registry
alias nversion="npm version"       # View and manage versioning
alias nrm="npm run"                # Run a npm script
alias nout="npm outdated"          # Check outdated packages

# pnpm Aliases
alias pni="pnpm install"           # Shortcut for pnpm install
alias pnis="pnpm install --save"    # Install and save in dependencies
alias pnisdev="pnpm install --save-dev" # Install and save as dev dependency
alias pnm="pnpm manager"           # Use pnpm as a manager alias
alias pnup="pnpm update"           # Update all packages using pnpm
alias pnstart="pnpm start"         # Start the application with pnpm
alias pnrun="pnpm run"             # Run pnpm scripts
alias pntest="pnpm test"           # Run pnpm tests
alias pnls="pnpm list"             # List installed pnpm packages
alias pnci="pnpm ci"               # Clean install with pnpm
alias pnpublish="pnpm publish"     # Publish to pnpm registry
alias pnversion="pnpm version"     # View and manage pnpm versioning
alias pnout="pnpm outdated"        # Check outdated pnpm packages

# Python Aliases
alias py="python"           # Shortcut for python
alias py3="python3"         # Shortcut for python3
alias pip="pip3"             # Use pip3 instead of pip
alias pipup="pip install --upgrade"  # Upgrade pip packages
alias pyvenv="python3 -m venv"      # Create a Python virtual environment
alias pyactivate="source venv/bin/activate"  # Activate a Python virtual environment
alias pydeactivate="deactivate"   # Deactivate a Python virtual environment
alias pyrun="python"         # Run a Python script
alias pycheck="python -m py_compile" # Check syntax without running
alias pytest="python -m pytest" # Run tests with pytest
alias pydoc="python -m pydoc"   # Launch Python documentation server
alias pylist="pip list"       # List installed Python packages
alias pyfreeze="pip freeze"   # List installed packages in requirements format
alias pyinstall="pip install"  # Install Python packages
alias pyuninstall="pip uninstall"  # Uninstall Python packages