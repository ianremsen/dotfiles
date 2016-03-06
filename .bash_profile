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

if [ -d "$HOME/bin" ]; then export PATH="$PATH:$HOME/bin"; fi

if [ -d "/usr/local/go" ]; then
    export PATH="$PATH:/usr/local/go/bin"
    export GOPATH="$HOME/code/go"
    export GOBIN="$GOPATH/bin"
fi

if [ -d "/usr/racket" ];   then export PATH="$PATH:/usr/racket/bin"; fi
if [ -d "/usr/bin/mono" ]; then export PATH="$PATH:/usr/bin/mono"; fi

if [ -d "/usr/local/dlang" ]; then
    _OLD_D_PATH="$PATH"
    _OLD_D_LIBRARY_PATH="$LIBRARY_PATH"
    _OLD_D_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
    _OLD_D_PS1="$PS1"

    export PATH="$PATH:/usr/local/dlang/dub:/usr/local/dlang/dmd-2.070.0/linux/bin64"
    export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/dlang/dmd-2.070.0/linux/lib64"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/dlang/dmd-2.070.0/linux/lib64"
    export DMD=dmd
    export DC=dmd
fi

if   [ -n "$(command -v yum)" ]     && ! [ -n "$(command -v dnf)" ]; then export PKG="yum"
elif [ -n "$(command -v apt-get)" ] && ! [ -n "$(command -v apt)" ]; then export PKG="apt-get"
elif [ -n "$(command -v dnf)" ];     then export PKG="dnf"
elif [ -n "$(command -v apt)" ];     then export PKG="apt"
elif [ -n "$(command -v pkg)" ];     then export PKG="pkg"
elif [ -n "$(command -v pacman)" ];  then export PKG="pacman"
fi

if [ -f "$HOME/.bashrc" ]; then source "$HOME/.bashrc"; fi

# Removes duplicate entries
if [ -n "$PATH" ]; then
    oldPATH="$PATH:"
    PATH=""
    while [ -n "$oldPATH" ]; do
        x="${oldPATH%%:*}"
        case "$PATH:" in
            *:"$x":*);;
            *) PATH="$PATH:$x";;
        esac
        oldPATH="${oldPATH#*:}"
    done
    PATH="${PATH#:}"
    unset oldPATH x
fi
