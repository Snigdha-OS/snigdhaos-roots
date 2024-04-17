#
# ~/.bashrc
#
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
append_path "$HOME/bin"
append_path "$HOME/.local/bin"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

alias ls='ls -l --color=auto'
alias grep='grep --color=auto'

if [[ $(tty) == */dev/tty* ]]; then
  PS1="\e[1;31m[\u\e[1;32mIP: $(ip -4 addr | grep -v '127.0.0.1' | grep -v 'secondary' | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | sed -z 's/\n/|/g;s/|\$/\n/' | rev | cut -c 2- | rev) | \e[1;31m]\n[>]\[\e[1;31m\]\$(pwd) $ \[\e[0m\]"
else
  PS1="\e[1;31m┌──[I'm \u\e[0m➜ \e[1;32mPublic IP: $(ip -4 addr | grep -v '127.0.0.1' | grep -v 'secondary' | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | sed -z 's/\n/|/g;s/|\$/\n/' | rev | cut -c 2- | rev)🔒\e[1;31m]\n└──╼[\e[1;32mSNIGDHA OS\e[1;31m]\[\e[1;31m\]\$(pwd)\n$ Command: \[\e[0m\]"
fi

alias rs="sudo pacman -Rs"
alias s="sudo pacman -S"
alias sy="sudo pacman -Syy"
alias up="sudo pacman -Syyu"
alias gc="git clone"
alias gm="git commit -m"
alias ga="git add ."
alias gp="git push"
alias ps="pip install"
alias lp="sudo pacman -U"
alias pv="python -m venv"
alias ins="sudo pacman -S"
alias unins="sudo pacman -Rs"
alias install="sudo pacman -S"
alias uninstall="sudo pacman -Rs"
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias ul="sudo rm /var/lib/pacman/db.lck"
alias vm="sudo systemctl enable --now vmtoolsd.service"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias ys="yay -S"
alias pas="paru -S"
alias wget="wget -c"
alias ..="cd .."

bind "set completion-ignore-case on"

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

if [[ $1 != no-repeat-flag && -z $NO_REPETITION ]]; then
  neofetch
fi
