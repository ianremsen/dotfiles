# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

case "$-" in
    *i*);;
    *) return;;
esac

if [ -f "$HOME/.bashspec" ]; then source "$HOME/.bashspec"; fi

HISTCONTROL="ignoreboth"
HISTSIZE="5000"
HISTFILESIZE="2500"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"
shopt -s histappend
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s checkwinsize
set -o noclobber

if [ -z "${debian_chroot:-}" ] && [ -r "/etc/debian_chroot" ]; then debian_chroot="$(cat /etc/debian_chroot)"; fi

case "$TERM" in
    xterm-color) color_prompt="yes";;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x "/usr/bin/tput" ] && tput setaf 1 >&/dev/null; then color_prompt="yes"
    else color_prompt=""
    fi
fi

if [ "$(uname)" == "FreeBSD" ] && ! [ -n "$(command -v gnuls)" ]; then export LSCOLORS="ExGxFxDxCxegedabagacad"; fi

if [ "$REMOTE" == "0" ]; then export PS1="\[\e[01;34m\]\u\[\e[0m\]\[\e[01;37m\]@\h\[\e[0m\]\[\e[00;37m\]:[\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\]]: \[\e[0m\]"
else export PS1="\[\e[01;31m\]\u\[\e[0m\]\[\e[01;37m\]@\h\[\e[0m\]\[\e[00;37m\]:[\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\]]: \[\e[0m\]"
fi

if [ "$USER" == "root" ]; then export PS1="\[\e[01;35m\]\u\[\e[0m\]\[\e[01;37m\]@\h\[\e[0m\]\[\e[00;37m\]:[\[\e[0m\]\[\e[00;33m\]\w\[\e[0m\]\[\e[00;37m\]]: \[\e[0m\]"; fi

if ! shopt -oq posix; then
    if   [ -f "/usr/share/bash-completion/bash_completion" ]; then source "/usr/share/bash-completion/bash_completion"
    elif [ -f "/etc/bash_completion" ]; then source "/etc/bash_completion"
    fi
fi

function genpass () {
    if [ -n "$1" ]; then SIZE="$1"
    else SIZE="32"; fi
    < /dev/urandom tr -dc A-Za-z0-9\$\&\!\%^@_*# | head -c "$SIZE"; echo ""
}

function lrg () {
    if [ -n "$1" ]; then SIZE="$1"
    else SIZE="40"; fi
    find $(pwd) -type f -size +"$SIZE"M 2>/dev/null -exec du -h {} +
}

export -f genpass
export -f lrg

if [ $(uname -a | awk '{print $7;}') == "Cygwin" ]; then
    if [ -z "$SSH_AUTH_SOCK" -a -x /usr/bin/ssh-pageant ]; then eval $(/usr/bin/ssh-pageant -q)
    elif [ -z "$SSH_AUTH_SOCK" -a -x "/usr/bin/ssh-agent" ]; then
        eval `/usr/bin/ssh-agent -s` > /dev/null
        trap "kill $SSH_AGENT_PID" 0
    fi

    trap logout HUP

    source "$HOME/.aliases"

    if hash setup-x86_64 2>/dev/null; then
        alias setup="setup-x86_64 -K http://cygwinports.org/ports.gpg"
        alias pkg-in="setup -qgdnP"
        alias pkg-u="setup -q"
        alias pkg-rm="setup -qgdnx"
    fi

    return
fi

if [ -f "$HOME/.aliases" ]; then source "$HOME/.aliases"; fi
