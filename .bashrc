#!/bin/bash
#
# ~/.bashrc
#

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

# Enable bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# Check if the shell is interactive, and only execute below in interactive shells
[[ $- != *i* ]] && return

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
bind "set completion-ignore-case on"

# Function for extracting different types of archives
ex () {
    if [ -f "$1" ]; then
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
    ip -4 addr show | grep -v '127.0.0.1' | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1
}

get_os_name() {
  if [[ -f /etc/os-release ]]; then
    local os_name=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    echo "$os_name"
  else
    echo "/etc/os-release file not found!"
  fi
}

if [[ $(tty) == */dev/tty* ]]; then
    PS1="\e[31m[\u\e[32mIP: $(get_ip_address) | \e[31m]\n[>]\[\e[31m\]\$(pwd) $ \[\e[0m\]"
else
    PS1="\e[31m┌──[\u\e[0m➜ \e[32m$(get_ip_address)\e[31m]\n└──╼[\e[32m$(get_os_name)\e[31m]\[\e[31m\]\$(pwd)\n$ Command: \[\e[0m\]"
fi

# Display system information via neofetch if the flag is not set
#if [[ $1 != "no-repeat-flag" && -z $NO_REPETITION ]]; then
#    neofetch
#fi

# Additional useful aliases
alias cls="clear"
alias h="history"
alias upg="sudo pacman -Syu"
alias restart="sudo reboot"
alias shutdown="sudo shutdown -h now"
alias halt="sudo shutdown -h now"
alias lock="i3lock"
alias logs="journalctl -xe"
alias t="tmux"
alias top="htop"
alias cpu="lscpu"
alias mem="free -h"
alias battery="upower -i $(upower -e | grep 'BAT') | grep 'state\|percentage'"

# Navigate the system more efficiently
alias src="cd ~/src"
alias code="code ."

# Git Aliases
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gco="git checkout"
alias gbr="git branch"
alias gb="git branch"
alias gl="git log"
alias glg="git log --oneline --graph --all"
alias gst="git stash"
alias gpo="git push origin"
alias gpl="git pull"
alias gup="git pull --rebase"
alias gd="git diff"
alias gds="git diff --staged"
alias gls="git ls-files"
alias gcl="git clone"
alias gtag="git tag"

# npm Aliases
alias ni="npm install"
alias nis="npm install --save"
alias nisdev="npm install --save-dev"
alias nup="npm update"
alias nstart="npm start"
alias nrun="npm run"
alias ntest="npm test"
alias nls="npm ls"
alias nci="npm ci"
alias nfund="npm fund"
alias npublish="npm publish"
alias nversion="npm version"
alias nrm="npm run"
alias nout="npm outdated"

# pnpm Aliases
alias pni="pnpm install"
alias pnis="pnpm install --save"
alias pnisdev="pnpm install --save-dev"
alias pnm="pnpm manager"
alias pnup="pnpm update"
alias pnstart="pnpm start"
alias pnrun="pnpm run"
alias pntest="pnpm test"
alias pnls="pnpm list"
alias pnci="pnpm ci"
alias pnpublish="pnpm publish"
alias pnversion="pnpm version"
alias pnout="pnpm outdated"

# Python Aliases
alias py="python"
alias py3="python3"
alias pip="pip3"
alias pipup="pip install --upgrade"
alias pyvenv="python3 -m venv"
alias pyactivate="source venv/bin/activate"
alias pydeactivate="deactivate"
alias pyrun="python"
alias pycheck="python -m py_compile"
alias pytest="python -m pytest"
alias pydoc="python -m pydoc"
alias pylist="pip list"
alias pyfreeze="pip freeze"
alias pyinstall="pip install"
alias pyuninstall="pip uninstall"

# C++ Aliases
alias cpp-compile="g++ -std=c++17 -Wall -Wextra -o output"
alias cpp-run="g++ -std=c++17 -Wall -Wextra -o output && ./output"
alias cpp-compile-opt="g++ -std=c++17 -O2 -Wall -Wextra -o output"
alias cpp-clean="rm -f output"
alias cpp-build-all="g++ -std=c++17 -Wall -Wextra *.cpp -o output"
alias cpp-edit="nano"
alias cpp-exec="./output"

# Rust Aliases
alias rustc="rustc"
alias rust-run="cargo run"
alias rust-build="cargo build"
alias rust-build-rel="cargo build --release"
alias rust-test="cargo test"
alias rust-clean="cargo clean"
alias rust-fmt="cargo fmt"
alias rust-clippy="cargo clippy"
alias rust-doc="cargo doc --open"
alias rust-new="cargo new"
alias rust-init="cargo init"
alias rust-add="cargo add"
alias rust-upd="rustup update"
alias rust-ver="rustc --version"
alias rust-watch="cargo watch -x run"
alias rust-deps="cargo tree"
alias rust-check="cargo check"
alias rust-ls="ls -alh --color=auto"

# Web Developer Aliases

## Frontend Frameworks
### React
alias react-create="npx create-react-app my-app --template typescript"
alias react-build="npm run build"
alias react-start="npm start"
alias react-test="npm test"
alias react-lint="npm run lint"

### Angular
alias ng-create="ng new my-app"
alias ng-serve="ng serve"
alias ng-build="ng build"
alias ng-test="ng test"
alias ng-lint="ng lint"

### Vue
alias vue-create="vue create my-app"
alias vue-serve="npm run serve"
alias vue-build="npm run build"
alias vue-test="npm run test"
alias vue-lint="npm run lint"

## Backend Frameworks
### Node.js
alias node-init="npm init -y"
alias node-start="node index.js"

### Express
alias express-create="npm install express"
alias express-start="node index.js"

### Django
alias django-create="django-admin startproject myproject"
alias django-run="python manage.py runserver"
alias django-migrate="python manage.py migrate"
alias django-app="python manage.py startapp myapp"
alias django-shell="python manage.py shell"

### Flask
alias flask-run="flask run"
alias flask-env="export FLASK_ENV=development"
alias flask-app="export FLASK_APP=app.py"

# Miscellaneous Web Development Tools
alias webpack-build="webpack --mode production"
alias webpack-dev="webpack --mode development"
alias sass-watch="sass --watch src/scss:dist/css"
alias tailwind-init="npx tailwindcss init"
alias tailwind-build="npx tailwindcss build src/styles.css -o dist/styles.css"

# Database Management
alias mysql-start="sudo systemctl start mysql"
alias mysql-stop="sudo systemctl stop mysql"
alias psql-start="sudo systemctl start postgresql"
alias psql-stop="sudo systemctl stop postgresql"
alias mongo-start="sudo systemctl start mongod"
alias mongo-stop="sudo systemctl stop mongod"

# Docker Aliases
alias docker-start="sudo systemctl start docker"
alias docker-stop="sudo systemctl stop docker"
alias docker-ps="docker ps"
alias docker-build="docker build -t"
alias docker-run="docker run -d -p"
alias docker-exec="docker exec -it"

# Kubernetes Aliases
alias k-start="kubectl apply -f"
alias k-stop="kubectl delete -f"
alias k-get-pods="kubectl get pods"
alias k-get-services="kubectl get services"
alias k-logs="kubectl logs"
alias k-exec="kubectl exec -it"

# DevOps and CI/CD
alias ansible-play="ansible-playbook"
alias terraform-init="terraform init"
alias terraform-apply="terraform apply"
alias terraform-plan="terraform plan"