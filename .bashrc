#!/bin/bash
#
# ~/.bashrc
#

# Function to append to PATH if not already present
append_path () {
    case ":$PATH:" in
        *:"$1":*) ;;  # If the given path is already in $PATH, do nothing
        *) PATH="${PATH:+$PATH:}$1" ;;  # Otherwise, append the given path to $PATH
    esac
}

# Add user bin directories to PATH if they exist
append_path "$HOME/bin"
append_path "$HOME/.local/bin"
append_path "$HOME/.bin"   # Append .bin only if directory exists

# Enable bash completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then  # Check if bash completion script is available at the first path
    . /usr/share/bash-completion/bash_completion  # Source the bash completion script to enable autocomplete features
elif [ -f /etc/bash_completion ]; then  # If the first path does not exist, check the second path for the script
    . /etc/bash_completion  # Source the bash completion script from the second location
fi  # End the conditional block

# Check if the shell is interactive, and only execute below in interactive shells
[[ $- != *i* ]] && return  # If the shell is not interactive (does not have 'i' in $-), return and do not execute further commands

# Set default aliases

alias ls='ls -l --color=auto'  # List directory contents in long format with colorized output
alias grep='grep --color=auto'  # Enable colorized output for grep command
alias rs="sudo pacman -Rs"  # Remove packages with dependencies using pacman
alias s="sudo pacman -S"  # Install packages with pacman
alias sy="sudo pacman -Syy"  # Sync package databases and update package list
alias syyu="sudo pacman -Syyu"  # Sync package databases and update system packages
alias lck="sudo rm /var/lib/pacman/db.lck"  # Remove pacman lock file (use with caution)
alias vm="sudo systemctl enable --now vmtoolsd.service"  # Enable VMware Tools service at boot
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"  # Display recently installed packages sorted by install date (last 200)
alias ys="yay -S"  # Install packages with yay (AUR helper)
alias pas="paru -S"  # Install packages with paru (another AUR helper)
alias wget="wget -c"  # Download files using wget and continue partially downloaded files
alias ..="cd .."  # Move up one directory in the filesystem
alias home="cd ~"  # Go to the home directory
alias docs="cd ~/Documents"  # Go to the Documents directory
alias dl="cd ~/Downloads"  # Go to the Downloads directory
alias music="cd ~/Music"  # Go to the Music directory
alias pics="cd ~/Pictures"  # Go to the Pictures directory
alias vids="cd ~/Videos"  # Go to the Videos directory
alias desk="cd ~/Desktop"  # Go to the Desktop directory

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
    if [ -f "$1" ]; then  # Check if the argument is a valid file
        case "$1" in  # Case structure to match different file extensions
            *.tar.bz2)   tar xjf "$1" ;;  # Extract .tar.bz2 files using tar
            *.tar.gz)    tar xzf "$1" ;;  # Extract .tar.gz files using tar
            *.bz2)       bunzip2 "$1" ;;  # Decompress .bz2 files
            *.rar)       unrar x "$1" ;;  # Extract .rar files using unrar
            *.gz)        gunzip "$1" ;;  # Decompress .gz files
            *.tar)       tar xf "$1" ;;  # Extract .tar files using tar
            *.tbz2)      tar xjf "$1" ;;  # Extract .tbz2 files using tar
            *.tgz)       tar xzf "$1" ;;  # Extract .tgz files using tar
            *.zip)       unzip "$1" ;;  # Extract .zip files using unzip
            *.Z)         uncompress "$1" ;;  # Decompress .Z files
            *.7z)        7z x "$1" ;;  # Extract .7z files using 7z
            *.deb)       ar x "$1" ;;  # Extract .deb package files using ar
            *.tar.xz)    tar xf "$1" ;;  # Extract .tar.xz files using tar
            *.tar.zst)   tar xf "$1" ;;  # Extract .tar.zst files using tar
            *)           echo "'$1' cannot be extracted via ex()" ;;  # Print a message if the file type is unsupported
        esac
    else
        echo "'$1' is not a valid file"  # Print an error if the argument is not a valid file
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

alias cls="clear"                             # Clear the terminal screen
alias h="history"                             # Show the command history
alias upg="sudo pacman -Syu"                  # Update the system with pacman (Arch-based)
alias restart="sudo reboot"                   # Restart the system
alias shutdown="sudo shutdown -h now"         # Shutdown the system immediately
alias halt="sudo shutdown -h now"             # Halt the system immediately (same as shutdown)
alias lock="i3lock"                           # Lock the screen using i3lock (for i3 users)
alias logs="journalctl -xe"                   # Show detailed logs from the system journal
alias t="tmux"                                # Start a new tmux session or attach to an existing one
alias top="htop"                              # Show interactive process viewer (htop)
alias cpu="lscpu"                             # Display CPU architecture information
alias mem="free -h"                           # Show memory usage in human-readable format
alias battery="upower -i $(upower -e | grep 'BAT') | grep 'state\|percentage'"  # Show battery status (for laptops)

# System monitoring
alias disk="df -h"                     # Disk space usage
alias du="du -h --max-depth=1"         # Disk usage in human-readable format, one directory level
alias iostat="iostat -xz 1"            # Disk I/O statistics
alias uptime="uptime"                  # Show system uptime
alias load="uptime | awk '{print $10, $11, $12}'"  # Show system load averages
alias meminfo="cat /proc/meminfo"      # Detailed memory information
alias netstat="netstat -tuln"          # Network statistics
alias ss="ss -tuln"                    # Socket statistics
alias ifconfig="ifconfig -a"           # Display network interfaces
alias ip="ip addr show"                # Show IP addresses of interfaces

# Package management (Arch-based)
alias pac="pacman"                     # Pacman package manager
alias paclist="pacman -Q"              # List installed packages
alias pacsearch="pacman -Ss"           # Search for packages
alias pacinfo="pacman -Qi"             # Get detailed package information
alias pacclean="sudo pacman -Rns $(pacman -Qdtq)"  # Remove orphaned packages
alias pacpurge="sudo pacman -Rns $(pacman -Qdtq); sudo pacman -Scc"  # Remove unused packages and clean the cache

# User management
alias users="who"                      # List currently logged in users
alias whoami="whoami"                  # Display the current logged-in user
alias groups="groups"                  # Show groups the user belongs to
alias lastlog="lastlog"                # Show last login information

# Navigate the system more efficiently
alias src="cd ~/src"                # Change directory to ~/src
alias code="code ."                  # Open the current directory in VSCode

# Git Aliases
alias gs="git status"                # Show the status of the current git repository
alias ga="git add"                   # Stage changes for commit
alias gaa="git add --all"            # Stage all changes, including new, modified, and deleted files
alias gc="git commit"                # Commit staged changes
alias gca="git commit --amend"       # Amend the last commit (modify the commit message or content)
alias gcm="git commit -m"            # Commit with a message
alias gco="git checkout"             # Switch branches or restore files
alias gbr="git branch"               # List all branches in the repository
alias gb="git branch"                # Alias for listing branches (same as gbr)
alias gl="git log"                   # View the commit history
alias glg="git log --oneline --graph --all"  # View the commit history in a concise graphical format
alias gst="git stash"                # Stash changes (save work in progress temporarily)
alias gpo="git push origin"          # Push changes to the remote repository (origin)
alias gpl="git pull"                 # Pull changes from the remote repository
alias gup="git pull --rebase"        # Pull changes and rebase (reapply local commits on top)
alias gd="git diff"                  # Show differences between files or commits
alias gds="git diff --staged"        # Show differences for staged files (ready to commit)
alias gls="git ls-files"             # List all tracked files in the repository
alias gcl="git clone"                # Clone a remote repository
alias gtag="git tag"                 # List, create, or delete tags in the repository
# npm Aliases
alias ni="npm install"               # Install dependencies from package.json
alias nis="npm install --save"        # Install and save dependencies to package.json (for regular dependencies)
alias nisdev="npm install --save-dev" # Install and save dependencies as devDependencies
alias nup="npm update"                # Update all dependencies to the latest versions
alias nstart="npm start"              # Run the start script defined in package.json
alias nrun="npm run"                  # Run a custom script defined in package.json
alias ntest="npm test"                # Run tests defined in package.json
alias nls="npm ls"                    # List installed packages
alias nci="npm ci"                    # Install dependencies from package-lock.json (clean installation)
alias nfund="npm fund"                # Show funding information for the installed packages
alias npublish="npm publish"          # Publish the package to npm registry
alias nversion="npm version"          # Show or change the version of the current package
alias nrm="npm run"                   # Alias to run any custom script, same as `npm run`
alias nout="npm outdated"             # Show which installed packages are outdated

# pnpm Aliases
alias pni="pnpm install"              # Install dependencies from package.json
alias pnis="pnpm install --save"      # Install and save dependencies to package.json (for regular dependencies)
alias pnisdev="pnpm install --save-dev" # Install and save dependencies as devDependencies
alias pnm="pnpm manager"              # Manage pnpm (usually refers to actions like pnpm install, update, etc.)
alias pnup="pnpm update"              # Update all dependencies to the latest versions
alias pnstart="pnpm start"            # Run the start script defined in package.json using pnpm
alias pnrun="pnpm run"                # Run a custom script defined in package.json with pnpm
alias pntest="pnpm test"              # Run tests defined in package.json using pnpm
alias pnls="pnpm list"                # List installed packages in the current project
alias pnci="pnpm ci"                  # Clean install (similar to npm ci), installs dependencies from lockfile
alias pnpublish="pnpm publish"        # Publish the package to a registry using pnpm
alias pnversion="pnpm version"        # Show or change the version of the current package using pnpm
alias pnout="pnpm outdated"           # Show which installed packages are outdated in a pnpm-managed project

# Python Aliases
alias py="python"                      # Run Python (default version)
alias py3="python3"                    # Run Python 3
alias pip="pip3"                        # Use pip3 for installing Python packages
alias pipup="pip install --upgrade"     # Upgrade installed Python packages
alias pyvenv="python3 -m venv"         # Create a virtual environment in Python 3
alias pyactivate="source venv/bin/activate" # Activate a Python virtual environment
alias pydeactivate="deactivate"        # Deactivate the Python virtual environment
alias pyrun="python"                   # Run a Python script with the default Python
alias pycheck="python -m py_compile"   # Check the syntax of a Python file (compile it)
alias pytest="python -m pytest"        # Run tests using pytest
alias pydoc="python -m pydoc"          # Access Python documentation via pydoc
alias pylist="pip list"                # List installed Python packages
alias pyfreeze="pip freeze"            # Show installed Python packages and their versions
alias pyinstall="pip install"          # Install Python packages
alias pyuninstall="pip uninstall"      # Uninstall Python packages

# C++ Aliases
alias cpp-compile="g++ -std=c++17 -Wall -Wextra -o output"   # Compile C++ code with g++ (C++17 standard)
alias cpp-run="g++ -std=c++17 -Wall -Wextra -o output && ./output"  # Compile and run C++ code
alias cpp-compile-opt="g++ -std=c++17 -O2 -Wall -Wextra -o output"  # Compile C++ code with optimization
alias cpp-clean="rm -f output"                             # Remove the compiled output file
alias cpp-build-all="g++ -std=c++17 -Wall -Wextra *.cpp -o output"  # Compile all C++ files in the directory
alias cpp-edit="nano"                                      # Open C++ code in the nano editor
alias cpp-exec="./output"                                   # Execute the compiled C++ output

# Rust Aliases
alias rustc="rustc"                                       # Run the Rust compiler
alias rust-run="cargo run"                                # Build and run a Rust project with Cargo
alias rust-build="cargo build"                            # Build the Rust project with Cargo
alias rust-build-rel="cargo build --release"              # Build the Rust project in release mode
alias rust-test="cargo test"                              # Run tests in a Rust project
alias rust-clean="cargo clean"                            # Clean up build artifacts in a Rust project
alias rust-fmt="cargo fmt"                                # Format Rust code using Cargo's built-in formatter
alias rust-clippy="cargo clippy"                          # Run Clippy for Rust code linting
alias rust-doc="cargo doc --open"                         # Build and open Rust documentation
alias rust-new="cargo new"                                # Create a new Rust project with Cargo
alias rust-init="cargo init"                              # Initialize an existing directory as a Rust project
alias rust-add="cargo add"                                # Add dependencies to a Rust project
alias rust-upd="rustup update"                            # Update Rust toolchain with rustup
alias rust-ver="rustc --version"                          # Display the installed Rust version
alias rust-watch="cargo watch -x run"                     # Run a Rust project with automatic rebuilds on code changes
alias rust-deps="cargo tree"                              # Display the dependency tree of a Rust project
alias rust-check="cargo check"                            # Check the Rust code without building
alias rust-ls="ls -alh --color=auto"                      # List files in a directory with color

# Web Developer Aliases

### React
alias react-create="npx create-react-app my-app --template typescript"  # Create a new React app with TypeScript template
alias react-build="npm run build"                                      # Build the React app for production
alias react-start="npm start"                                          # Start the React app in development mode
alias react-test="npm test"                                            # Run tests in the React app
alias react-lint="npm run lint"                                        # Lint the React app's code

### Angular
alias ng-create="ng new my-app"                                        # Create a new Angular project
alias ng-serve="ng serve"                                              # Serve the Angular app in development mode
alias ng-build="ng build"                                              # Build the Angular app for production
alias ng-test="ng test"                                                # Run tests in the Angular app
alias ng-lint="ng lint"                                                # Lint the Angular app's code

### Vue
alias vue-create="vue create my-app"                                  # Create a new Vue app
alias vue-serve="npm run serve"                                        # Serve the Vue app in development mode
alias vue-build="npm run build"                                        # Build the Vue app for production
alias vue-test="npm run test"                                          # Run tests in the Vue app
alias vue-lint="npm run lint"                                          # Lint the Vue app's code

## Backend Frameworks
### Node.js
alias node-init="npm init -y"                                          # Initialize a new Node.js project with default settings
alias node-start="node index.js"                                      # Start a Node.js app (index.js)

### Express
alias express-create="npm install express"                             # Install Express.js for a project
alias express-start="node index.js"                                    # Start an Express app (index.js)

### Django
alias django-create="django-admin startproject myproject"              # Create a new Django project
alias django-run="python manage.py runserver"                          # Start the Django development server
alias django-migrate="python manage.py migrate"                        # Run database migrations in Django
alias django-app="python manage.py startapp myapp"                     # Create a new Django app within the project
alias django-shell="python manage.py shell"                            # Open Django shell for interactive work

### Flask
alias flask-run="flask run"                                            # Run a Flask app in development mode
alias flask-env="export FLASK_ENV=development"                         # Set Flask environment to development
alias flask-app="export FLASK_APP=app.py"                              # Set the entry point for Flask app (app.py)

# Miscellaneous Web Development Tools
alias webpack-build="webpack --mode production"                        # Build project using Webpack in production mode
alias webpack-dev="webpack --mode development"                         # Build project using Webpack in development mode
alias sass-watch="sass --watch src/scss:dist/css"                      # Watch and compile SASS files to CSS
alias tailwind-init="npx tailwindcss init"                             # Initialize Tailwind CSS configuration file
alias tailwind-build="npx tailwindcss build src/styles.css -o dist/styles.css"  # Build Tailwind CSS styles

# Database Management
alias mysql-start="sudo systemctl start mysql"                         # Start MySQL service
alias mysql-stop="sudo systemctl stop mysql"                           # Stop MySQL service
alias psql-start="sudo systemctl start postgresql"                     # Start PostgreSQL service
alias psql-stop="sudo systemctl stop postgresql"                       # Stop PostgreSQL service
alias mongo-start="sudo systemctl start mongod"                        # Start MongoDB service
alias mongo-stop="sudo systemctl stop mongod"                          # Stop MongoDB service

# Docker Aliases
alias docker-start="sudo systemctl start docker"                       # Start Docker service
alias docker-stop="sudo systemctl stop docker"                         # Stop Docker service
alias docker-ps="docker ps"                                           # List running Docker containers
alias docker-build="docker build -t"                                   # Build a Docker image with the specified tag
alias docker-run="docker run -d -p"                                    # Run a Docker container in detached mode with port binding
alias docker-exec="docker exec -it"                                    # Execute commands inside a running Docker container

# Kubernetes Aliases
alias k-start="kubectl apply -f"                                       # Apply Kubernetes configuration from a file
alias k-stop="kubectl delete -f"                                       # Delete Kubernetes resources defined in a file
alias k-get-pods="kubectl get pods"                                     # Get the list of Kubernetes pods
alias k-get-services="kubectl get services"                             # Get the list of Kubernetes services
alias k-logs="kubectl logs"                                             # View logs of a specific Kubernetes pod
alias k-exec="kubectl exec -it"                                         # Execute commands inside a Kubernetes pod

# DevOps and CI/CD
alias ansible-play="ansible-playbook"                                  # Run an Ansible playbook
alias terraform-init="terraform init"                                  # Initialize Terraform project
alias terraform-apply="terraform apply"                                # Apply Terraform configuration to provision resources
alias terraform-plan="terraform plan"                                  # Preview changes Terraform will make to infrastructure
