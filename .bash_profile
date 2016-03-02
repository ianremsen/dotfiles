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
