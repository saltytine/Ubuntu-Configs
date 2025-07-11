# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

whoami() {
  cat <<'EOF'
  _____       _ _   _
 / ____|     | | | (_)  1 & 0nly
| (___   __ _| | |_ _ _ __   ___
 \___ \ / _` | | __| | '_ \ / _ \
 ____) | (_| | | |_| | | | |  __/
|_____/ \__,_|_|\__|_|_| |_|\___|
EOF
}

dc() {
  cd "$@"
}

v() {
  nvim "$@"
}

sv() {
  sudo nvim "$@"
}

mkc() {
    mkdir -p "$1" && cd "$1"
}

cdg() {
    cd "$(git rev-parse --show-toplevel)" || echo "not in a git repo"
}

gurl() {
  xdg-open "$(git config --get remote.origin.url | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')"
}

gwho() {
  if [[ -z "$1" ]]; then
    git log -n 1 --pretty=format:"%an committed %ar" -- .
  else
    git log -n 1 --pretty=format:"%an committed %ar" -- "$1"
  fi
}

ipwho() {
  curl -s "ipinfo.io/$1" | jq
}

notrash() {
  rm -rf ~/.local/share/Trash/files/*
}

whatisthis() {
  file "$1"
  stat "$1"
  mimetype "$1"
}

catparty() {
  for i in {1..20}; do
    echo "😾 CAT $i 🐾" | lolcat
    sleep 0.1
  done
}

why() {
  local reasons=(
    "I said so"
  )

  while :; do
    echo -e "\033[1;31mWhy?\033[0m"
    sleep 1
    echo -e "\033[1;32mBecause ${reasons[$RANDOM % ${#reasons[@]}]}.\033[0m"
    sleep 2
  done
}

exec {__bash_trace_fd}>/dev/null

export BASH_XTRACEFD=$__bash_trace_fd

[[ -e /proc/$$/fd/$__bash_trace_fd ]] && \
    eval "exec {__bash_trace_fd}>&-; exec {__bash_trace_fd}<>/dev/null; BASH_XTRACEFD=$__bash_trace_fd"

shopt -s autocd

alias neofetch='neofetch --image_backend kitty --source /home/user/Pictures/merusuccubi.png'

export VISUAL=nvim
export EDITOR=nvim

alias time='date +%T'
alias p='cd ~/Coding/'
alias home='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias q='clear'
alias k='tmux kill-server'
alias please='sudo $(fc -ln -1)'
alias update='sudo apt update && sudo apt upgrade -y'
alias k9='kill -9'

alias h='history'
alias hg='history | grep'

alias serve='python3 -m http.server'
alias ip='curl ifconfig.me -w "\n"'

alias notes='cd ~/notes-and-guides'
alias vtodo='nvim +$ ~/todo.md'
alias todo='cat ~/todo.md'
alias weather='curl wttr.in'

alias f='/home/user/Coding/scripts/format.sh'
# tmux \; \
#   split-window -h -l 80 -- 'btop' \; \
#   split-window -v -l 20 -- 'kew' \; \
#   select-pane -L \; \
#   split-window -v -l 20 -- 'ranger' \; \
#   select-pane -U \; \
#   attach

alias roll='/home/user/.local/bin/rolldice.sh'
# if [[ $# -ne 1 ]]; then
#     echo "Usage: roll <NdM> (e.g., 2d6, 1d20)"
#     exit 1
# fi
#
# input="$1"
#
# if ! [[ "$input" =~ ^([1-9][0-9]*)[dD]([1-9][0-9]*)$ ]]; then
#     echo "Format must be NdM, like 2d6 or 1d20. Not your malformed bullshit."
#     exit 1
# fi
#
# num_dice="${BASH_REMATCH[1]}"
# num_sides="${BASH_REMATCH[2]}"
#
# total=0
# results=()
#
# for ((i=0; i<num_dice; i++)); do
#     roll=$(( RANDOM % num_sides + 1 ))
#     results+=("$roll")
#     (( total += roll ))
# done
#
# echo "Rolled: ${results[*]}  |  Total: $total"

alias gitea='/home/user/Coding/scripts/gitea.sh' # remember to change the branches
alias github='/home/user/Coding/scripts/github.sh' # remember to change the branches
