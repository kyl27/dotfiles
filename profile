# ~/.profile skeleton
# ~/.profile runs on interactive login shells if it exists
# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo "~/.profile has run"

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# commandline editing
# set -o emacs    # emacs style command line mode (default)
set -o vi      # vi style command line mode

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# this variable needs to be set for pnewtask/pnewscript to function
# if you don't know what to put here leave it alone or ask your team.
#GROUP=put_your_group_here

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# below block is executed if:
# chimera is not present/didn't run
# set some basic stuff up, hope /etc/passwd is good enough
if [ ! "$BBENV" ] 
then
     PS1="${HOSTNAME}:\${PWD}\$ " 
     PATH=/user/sbin:$PATH
     ##LPDEST=put_your_printer_here
     ##GROUP=put_your_group_here
     stty erase \^\h kill \^u intr \^c
     stty echoe echok ixon ixoff -ixany

     if [ $(uname) = "SunOS" ] && [ ! "$BASH" ]
     then
          set -o emacs
          alias __A=$(print '\0020') # ^P = up = previous command
          alias __B=$(print '\0016') # ^N = down = next command
          alias __C=$(print '\0006') # ^F = right = forward a character
          alias __D=$(print '\0002') # ^B = left = back a character
          alias __H=$(print '\0001') # ^A = home = beginning of line
          #stty erase ^?
          #echo "SunOS keys set"
     fi
fi

alias la="ls -a"
alias mksub="/bbshr/ib/bin/mksub.pl"
alias eclipse_wizard="/home/pshepher/bin/eclipse_wizard.py"
alias nova=". nova.sh"
alias path='echo $path | tr ":" "\n"'

. /bb/unsupported/scrputil/team_profile/scrp.env
. /bb/bigstorq4/scrpbuild/devtools/bin/verbose_history.bash

source ~/.bashrc

[ -f ~/.ssh/bcpc-auth ] && source ~/.ssh/bcpc-auth

# =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[ "$GROUP" ] && export GROUP 
stty sane # should normalize backspace issues?
