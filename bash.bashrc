# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

# ALIASES
alias upower="upower -i $(upower -e | grep 'bat') | grep -E 'time|percentage'"
#alias noproxy="sudo mv /etc/apt/apt.conf.d/90proxy /etc/apt/apt.conf.d/temp/"
#alias proxy="sudo mv /etc/apt/apt.conf.d/temp/90proxy /etc/apt/apt.conf.d/"
alias monitor="xrandr --output eDP1 --auto --output HDMI1 --auto --right-of eDP1"
#alias share="sudo mount -t vboxsf -o rw,uid=1000,gid=1000 share /media/sf_SHARE"
alias myip="wget -qO- http://ipecho.net/plain 2> /dev/null ; echo"
alias mytorip="torify wget -qO- http://ipecho.net/plain 2> /dev/null ; echo"
alias vpn_dcs="sudo openvpn --config /home/xyz/client.ovpn"
alias davmail="/opt/davmail-linux-x86_64-4.7.1-2416/davmail.sh & disown"
alias netmon="sudo netstat -netpc | egrep -v "127\.0\.0\.1:[0-9]{1,6}[[:blank:]]*127\.0\.0\.1:[0-9]{1,6}" | grep -v "iceweasel" | grep "192.168.""

# COLORIZE MY TERMINAL
color_prompt=yes
force_color_prompt=yes
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# FUNC
genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=16
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
