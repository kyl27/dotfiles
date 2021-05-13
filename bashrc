###############################################################################
################################### MY BASHRC FILE ############################
###############################################################################

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# for resolving pesky os differing switches
OS=$(uname)

if [ "$OS" = "Darwin" ]; then
    alias ls='ls -GFh'
else
    alias ls='ls --color -GFh'
fi

export LSCOLORS=gxbxcxfxdxegedabagacad
export LS_COLORS=$LS_COLORS:'di=01;34:fi=01;37:ln=01;31:pi=01;33:so=01;32:bd=01;34;46:cd=01;34;43:or=30;41:mi=30;41:ex=01;33'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ag='ag -s --color-match "1;31" --pager "less -n"'

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

# Bash local
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi




##################################################
# This bashrc's current prompt		             #
##################################################

PS1='\[\033]0;\w\007\]\[\e[95m\]\u\[\e[32m\]@\h\[\e[32m\]:\[\e[36m\]\w \[\e[93m\]\$ \[\e[37m\]'

# trap 'printf "\e[0m" "$_"' DEBUG


# Saves terminal commands in history file in real time (for use with 'shopt -s histappend')
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
# use with 'shopt -s histappend';save terminal commands in history file in real time



# autoload -U compinit				# use to enable famous zsh tab-completion system
# compinit					# use to enable famous zsh tab-completion system
export BLOCKSIZE=K				# set blocksize size
export EDITOR='vim'				# use default text editor
# export GREP_OPTIONS='-D skip --binary-files=without-match --ignore-case'		# most commonly used grep options
export HISTCONTROL=ignoreboth:erasedups		# for 'ignoreboth': ignore duplicates and /^\s/
export HISTIGNORE='&:bg:fg:ll:h'
export HISTSIZE=10000				# increase or decrease the size of the history to '10,000'
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a  '	# makes history display in YYYY-MM-DD_HH:MM:SS_3CharWeekdaySpaceSpace format
export HOSTFILE=$HOME/.hosts    		# put list of remote hosts in ~/.hosts ...
export LESSCHARSET='latin1'
export LESS='-i -w -z-4 -M -X -F -R -P%t?f%f \'
# export LESSOPEN="|lesspipe.sh %s"; export LESSOPEN
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'	# use this if lesspipe.sh exists
export TERM='xterm'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'

set -o notify					# notify when jobs running in background terminate
shopt -s cdable_vars				# set the bash option so that no '$' is required (disallow write access to terminal)
shopt -s cdspell				# this will correct minor spelling errors in a cd command
shopt -s checkhash
shopt -s checkwinsize				# update windows size on command
shopt -s cmdhist          			# save multi-line commands in history as single line
shopt -s extglob				# necessary for bash completion (programmable completion)
shopt -s histappend histreedit histverify
shopt -s mailwarn				# keep an eye on the mail file (access time)
shopt -s nocaseglob       			# pathname expansion will be treated as case-insensitive (auto-corrects the case)
shopt -s no_empty_cmd_completion		# no empty completion (bash>=2.04 only)
shopt -s sourcepath
stty start undef
stty stop undef
ulimit -S -c 0          			# (core file size) don't want any coredumps
unset MAILCHECK        				# don't want my shell to warn me of incoming mail



##################################################
# PATH                                           #
##################################################

if [[ -z $TMUX ]]; then
    PATH=$PATH:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
    
    # remove duplicate path entries
    export PATH=$(echo $PATH | awk -F: '
    { for (i = 1; i <= NF; i++) arr[$i]; }
    END { for (i in arr) printf "%s:" , i; printf "\n"; } ')
else
    cd ~
fi

# autocomplete ssh commands
complete -W "$(echo `cat ~/.bash_history | egrep '^ssh ' | sort | uniq | sed 's/^ssh //'`;)" ssh


##################################################
# Bashrc greetings                               #
##################################################

#### greeting
# from Jonathan's .bashrc file (by ~71KR117)
# get current hour (24 clock format i.e. 0-23)
hour=$(date +"%H")
# if it is midnight to midafternoon will say G'morning
if [ $hour -ge 0 -a $hour -lt 12 ]
then
  greet="Good Morning, Kevin. Welcome back."
# if it is midafternoon to evening ( before 6 pm) will say G'noon
elif [ $hour -ge 12 -a $hour -lt 18 ]
then
  greet="Good Afternoon, Kevin. Welcome back."
else # it is good evening till midnight
  greet="Good Evening, Kevin. Welcome back."
fi
# display greeting
# echo $greet



#### holiday greeting
# from Joathan's .bashrc file (by ~71KR117)
# get current day (Month-Day Format)
day=$(date +"%B%e")
# get current year (for new years greeting)
year=$(date +"%Y")
# make sure the holiday greeting is displayed (if any)
hol=1
# if it is New Year's Day
if [ "$day" = "January1" ]
then
  holgreet="Happy New Year. Have a Happy $year."
# if it is Groundhog Day
elif [ "$day" = "February2" ]
then
  holgreet="Have a Happy Groundhog Day."
# if it is Valentine's Day
elif [ "$day" = "February14" ]
then
  holgreet="Happy Valentine's Day <3."
# if it is Independance Day
elif [ "$day" = "July4" ]
then
  holgreet="Have a Happy Forth of July! Land of the free and home of the brave."
# if it is my birthday
elif [ "$day" = "April13" ]
then
  holgreet="Happy Birthday, Kevin!"
# if it is Halloween
elif [ "$day" = "October31" ]
then
  holgreet="Happy Halloween. Boo!"
# if it is Christmas Eve
elif [ "$day" = "December24" ]
then
  holgreet="Merry Christmas Eve."
# if it is Christmas
elif [ "$day" = "December25" ]
then
  holgreet="Merry Christmas."
# if it is New Year's Eve
elif [ "$day" = "December31" ]
then
  holgreet="Happy New Year's Eve."
else
  hol=0
fi
# display holiday greeting
if [ "$hol" = "1" ]
then
echo $holgreet
elif [ "$hol" = "0" ]
then
  randomvarthatsomehowimportant=0
fi



##################################################
# 'Universal' completion function		 #
##################################################

######  it works when commands have a so-called 'long options' mode
# ie: 'ls --all' instead of 'ls -a'
# Needs the '-o' option of grep
# (try the commented-out version if not available).
# First, remove '=' from completion word separators
# (this will allow completions like 'ls --color=auto' to work correctly).
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}



##################################################
# To enable tab-completion with sudo		 #
##################################################

###### alternatively, install bash-completion, which does this too
# complete -cf sudo


######################################################################################################################################################
###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS ###### FUNCTIONS
######################################################################################################################################################


##################################################
# Network information and IP address stuff	 #
##################################################

###### get all IPs via ifconfig
function allips()
{
ifconfig | awk '/inet / {sub(/addr:/, "", $2); print $2}'
}

###### clear iptables rules safely
function clearIptables()
{
iptables -P INPUT ACCEPT; iptables -P FORWARD ACCEPT; iptables -P OUTPUT ACCEPT; iptables -F; iptables -X; iptables -L
}



###### online check
function connected() { ping -c1 -w2 google.com > /dev/null 2>&1; }



function connected_() { rm -f /tmp/connect; http_proxy='http://a.b.c.d:8080' wget -q -O /tmp/connect http://www.google.com; if [[ -s /tmp/connect ]]; then return 0; else return 1; fi; }



###### check if a remote port is up using dnstools.com
# (i.e. from behind a firewall/proxy)
function cpo() { [[ $# -lt 2 ]] && echo 'need IP and port' && return 2; [[ `wget -q "http://dnstools.com/?count=3&checkp=on&portNum=$2&target=$1&submit=Go\!" -O - |grep -ic "Connected successfully to port $2"` -gt 0 ]] && echo OPEN || echo CLOSED; }



###### find an unused unprivileged TCP port
function findtcp()
{
(netstat  -atn | awk '{printf "%s\n%s\n", $4, $4}' | grep -oE '[0-9]*$'; seq 32768 61000) | sort -n | uniq -u | head -n 1
}


###### ifconfig connection check
function ips()
{
    if [ "$OS" = "Linux" ]; then
        for i in $( /sbin/ifconfig | grep ^e | awk '{print $1}' | sed 's/://' ); do echo -n "$i: ";  /sbin/ifconfig $i | perl -nle'/dr:(\S+)/ && print $1'; done
    elif [ "$OS" = "Darwin" ]; then
        for i in $( /sbin/ifconfig | grep ^e | awk '{print $1}' | sed 's/://' ); do echo -n "$i: ";  /sbin/ifconfig $i | perl -nle'/inet (\S+)/ && print $1'; done
    fi
}



###### geolocate a given IP address
function ip2loc() { wget -qO - www.ip2location.com/$1 | grep "<span id=\"dgLookup__ctl2_lblICountry\">" | sed 's/<[^>]*>//g; s/^[\t]*//; s/&quot;/"/g; s/</</g; s/>/>/g; s/&amp;/\&/g'; }




###### netinfo - shows network information for your system
function netinfo()
{
echo "--------------- Network Information ---------------"
/sbin/ifconfig | awk /'inet addr/ {print $2}'
/sbin/ifconfig | awk /'Bcast/ {print $3}'
/sbin/ifconfig | awk /'inet addr/ {print $4}'
/sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
echo "${myip}"
echo "---------------------------------------------------"
}



###### check whether or not a port on your box is open
function portcheck() { for i in $@;do curl -s "deluge-torrent.org/test-port.php?port=$i" | sed '/^$/d;s/<br><br>/ /g';done; }



##################################################
# Miscellaneous Fun				 #
##################################################

###### anagrams
function anagrams()
{
cat > "/tmp/anagrams.py" <<"End-of-message"
#!/usr/bin/python
infile = open ("/usr/share/dict/words", "r")
## "dict" is a reserved word
words_in = infile.readlines()
scrambled = raw_input("Enter the scrambled word: ")
scrambled = scrambled.lower()
scrambled_list = list(scrambled)
scrambled_list.sort()
for word in words_in:
    word_list = list(word.strip().lower())
    word_list.sort()
    ## you don't really have to compare lengths when using lists as the
    ## extra compare takes about as long as finding the first difference
    if word_list == scrambled_list:
        print word, scrambled
End-of-message
chmod +x "/tmp/anagrams.py"
"/tmp/anagrams.py" "$1"
rm "/tmp/anagrams.py"
}

###### watch the National debt clock
function natdebt()
{
watch -n 10 "wget -q http://www.brillig.com/debt_clock -O - | grep debtiv.gif | sed -e 's/.*ALT=\"//' -e 's/\".*//' -e 's/ //g'"
}



function oneliners()
{
w3m -dump_source http://www.onelinerz.net/random-one-liners/1/ | awk ' /.*<div id=\"oneliner_[0-9].*/ {while (! /\/div/ ) { gsub("\n", ""); getline; }; gsub (/<[^>][^>]*>/, "", $0); print $0}'
}


##################################################
# Temporarily add to PATH			 #
##################################################

function apath()
{
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Temporarily add to PATH"
        echo "usage: apath [dir]"
    else
        PATH=$1:$PATH
    fi
}



##################################################
# Function you want after you've overwritten some#
# important file using > instead of >> ^^	 #
##################################################

function append() {
        lastarg="${!#}"
        echo "${@:1:$(($#-1))}" >> "$lastarg"
}




###### grep by paragraph instead of by line
function grepp() { [ $# -eq 1 ] && perl -00ne "print if /$1/i" || perl -00ne "print if /$1/i" < "$2";}



function hgg()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "search bash history"
        echo "usage: hgg [search pattern]"
    else
        history | grep -i $1 | grep -v hg
    fi
}


function lsofg()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "grep lsof"
        echo "usage: losfg [port/program/whatever]"
    else
        lsof | grep -i $1 | less
    fi
}


function psg()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "grep running processes"
        echo "usage: psg [process]"
    else
        ps aux | grep USER | grep -v grep
        ps aux | grep -i $1 | grep -v grep
    fi
}


###### simple calculator to 4 decimals
function calc() {
echo "scale=4; $1" | bc
}


function clock()
{
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done
}


##################################################
# Print working directory after a cd.		 #
##################################################

# function cd() {
#     if [[ $@ == '-' ]]; then
#         builtin cd "$@" > /dev/null  # We'll handle pwd.
#     else
#         builtin cd "$@"
#     fi
#     echo -e "   \033[1;30m"`pwd`"\033[0m"
# }



##################################################
# Change directory and list files		 #
##################################################

function cds() {
    # only change directory if a directory is specified
    [ -n "${1}" ] && cd $1
    lls
}



##################################################
# Grep, grep, grep				 #
##################################################

###### to grep through files found by find, e.g. grepf pattern '*.c'
# note that 'grep -r pattern dir_name' is an alternative if want all files
function grepfind() { find . -type f -name "$2" -print0 | xargs -0 grep "$1" ; }

###### to grep through the /usr/include directory
function grepincl() { (cd /usr/include; find . -type f -name '*.h' -print0 | xargs -0 grep "$1" ) ; }


###### rot13 ("rotate alphabet 13 places" Caesar-cypher encryption)
function rot13()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "Seriously?  You don't know what rot13 does?"
    else
        echo $@ | tr A-Za-z N-ZA-Mn-za-m
    fi
}



###### rot47 ("rotate ASCII characters from '!" to '~' 47 places" Caesar-cypher encryption)
function rot47()
{
    if [ $# -lt 1 ] || [ $# -gt 1 ]; then
        echo "Seriously?  You don't know what rot47 does?"
    else
        echo $@ | tr '!-~' 'P-~!-O'
    fi
}

##################################################
# Super stealth background launch		 #
##################################################

function daemon()
{
    (exec "$@" >&/dev/null &)
}


##################################################
# Lists unique IPs currently connected to 	 #
# logged-in system & how many concurrent 	 #
# connections each IP has			 #
##################################################

function doscheck()
{
    netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
}



##################################################
# Show computer information of all sorts	 #
# (requires 'gawk': sudo apt-get install gawk)	 #
##################################################

###### machine details
function ii()
{
    echo -e "\n${RED}You are logged onto:$NC " ; hostname
    echo -e "\n${RED}Additionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date:$NC " ; date
    echo -e "\n${RED}Machine stat:$NC " ; uptime
    echo -e "\n${RED}Disk space:$NC " ; df -h
    echo -e "\n${RED}Memory stats (in MB):$NC " ;
    if [ "$OS" = "Linux" ]; then
        free -m
    elif [ "$OS" = "Darwin" ]; then
        vm_stat
    fi
    echo -e "\n${RED}IPs:$NC " ; ips
}


##################################################
# User friendly ps				 #
##################################################

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }



##################################################
# Stopwatch and Countdown Timer			 #
##################################################

function stopwatch() {
# copyright 2007 - 2010 Christopher Bratusek
BEGIN=$(date +%s)
while true; do
    NOW=$(date +%s)
    DIFF=$(($NOW - $BEGIN))
    MINS=$(($DIFF / 60))
    SECS=$(($DIFF % 60))
    echo -ne "Time elapsed: $MINS:`printf %02d $SECS`\r"
    sleep .1
done
}



##################################################
# Checks to ensure that all 			 #
# environment variables are valid		 #
##################################################

###### looks at SHELL, HOME, PATH, EDITOR, MAIL, and PAGER
function validator()
{
errors=0
function in_path()
{
  # given a command and the PATH, try to find the command. Returns
  # 1 if found, 0 if not.  Note that this temporarily modifies the
  # the IFS input field seperator, but restores it upon completion.
  cmd=$1    path=$2    retval=0
  oldIFS=$IFS; IFS=":"
  for directory in $path
  do
    if [ -x $directory/$cmd ] ; then
      retval=1      # if we're here, we found $cmd in $directory
    fi
  done
  IFS=$oldIFS
  return $retval
}
function validate()
{
  varname=$1    varvalue=$2
  if [ ! -z $varvalue ] ; then
    if [ "${varvalue%${varvalue#?}}" = "/" ] ; then
      if [ ! -x $varvalue ] ; then
        echo "** $varname set to $varvalue, but I cannot find executable."
        errors=$(( $errors + 1 ))
      fi
    else
      if in_path $varvalue $PATH ; then
        echo "** $varname set to $varvalue, but I cannot find it in PATH."
        errors=$(( $errors + 1 ))
      fi
    fi
  fi
}
####### Beginning of actual shell script #######
if [ ! -x ${SHELL:?"Cannot proceed without SHELL being defined."} ] ; then
  echo "** SHELL set to $SHELL, but I cannot find that executable."
  errors=$(( $errors + 1 ))
fi
if [ ! -d ${HOME:?"You need to have your HOME set to your home directory"} ]
then
  echo "** HOME set to $HOME, but it's not a directory."
  errors=$(( $errors + 1 ))
fi
# Our first interesting test: are all the paths in PATH valid?
oldIFS=$IFS; IFS=":"     # IFS is the field separator. We'll change to ':'
for directory in $PATH
do
  if [ ! -d $directory ] ; then
      echo "** PATH contains invalid directory $directory"
      errors=$(( $errors + 1 ))
  fi
done
IFS=$oldIFS             # restore value for rest of script
# Following can be undefined, & also be a progname, rather than fully qualified path.
# Add additional variables as necessary for your site and user community.
validate "EDITOR" $EDITOR
validate "MAILER" $MAILER
validate "PAGER"  $PAGER
# and, finally, a different ending depending on whether errors > 0
if [ $errors -gt 0 ] ; then
  echo "Errors encountered. Please notify sysadmin for help."
else
  echo "Your environment checks out fine."
fi
}

alias mv='mv -iv'
alias ping='ping -c 10'
alias reboot='sudo /sbin/reboot'
alias vi='vim'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'




##################################################
# Miscellaneous Fun				 #
##################################################
alias etchasketch='c=12322123;x=20;y=20;while read -sn1 p;do k=${c:(p-1)*2:2};let x+=$((k/10-2));let y+=$((k%10-2));echo -en \\033[$y\;"$x"HX;done'	# use the 1 2 3 and 4 keys to move the cursor around the screen (It's an etch-a-sketch for your terminal!)
alias excuses='echo `telnet bofh.jeffballard.us 666 2>/dev/null` |grep --color -o "Your excuse is:.*$"'		# excuses
alias freechess='telnet fics.freechess.org 5000'						# connects to a telnet server for free internet chess
alias funfacts='wget http://www.randomfunfacts.com -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;";'
alias funknet='telnet the-funk.net 7000'							# Access to Funk.net
alias futurama='curl -Is slashdot.org | sed -n '5p' | sed 's/^X-//''				# get Futurama quotations from slashdot.org servers
alias guitartune='for n in E2 A2 D3 G3 B3 E4;do play -n synth 4 pluck $n repeat 2;done'		# tune your guitar from the command line
alias iamcow='fortune | cowsay'
alias iamsurprise='fortune | cowsay -f $(random_cow)'
alias insults='wget http://www.randominsults.net -O - 2>/dev/null | grep \<strong\> | sed "s;^.*<i>\(.*\)</i>.*$;\1;";'
alias matrix='echo -e "\e[32m"; while :; do for i in {1..16}; do r="$(($RANDOM % 2))"; if [[ $(($RANDOM % 5)) == 1 ]]; then if [[ $(($RANDOM % 4)) == 1 ]]; then v+="\e[1m $r   "; else v+="\e[2m $r   "; fi; else v+="     "; fi; done; echo -e "$v"; v=""; done'
alias matrix2='echo -e "\e[31m"; while $t; do for i in `seq 1 30`;do r="$[($RANDOM % 2)]";h="$[($RANDOM % 4)]";if [ $h -eq 1 ]; then v="\e[1m $r";else v="\e[2m $r";fi;v2="$v2 $v";done;echo -e $v2;v2="";done;'
alias matrix3='COL=$(( $(tput cols) / 2 )); clear; tput setaf 2; while :; do tput cup $((RANDOM%COL)) $((RANDOM%COL)); printf "%$((RANDOM%COL))s" $((RANDOM%2)); done'
alias matrix4='echo -ne "\e[32m" ; while true ; do echo -ne "\e[$(($RANDOM % 2 + 1))m" ; tr -c "[:print:]" " " < /dev/urandom | dd count=1 bs=50 2> /dev/null ; done'
alias matrix5='tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=lcase,unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
alias roulette='[ $[ $RANDOM % 6 ] == 0 ] && echo Die || echo Live'				# command line Russian roulette
alias screensaver='for ((;;)); do echo -ne "\033[$((1+RANDOM%LINES));$((1+RANDOM%COLUMNS))H\033[$((RANDOM%2));3$((RANDOM%8))m$((RANDOM%10))"; sleep 0.1 ; done'												# terminal screensaver
alias starwars='telnet towel.blinkenlights.nl'							# the famous starwars ASCII version from telnet



##################################################
# Network/Internet -oriented stuff		 #
##################################################

alias bandwidth='dd if=/dev/zero of=/dev/null bs=1M count=32768'			# processor / memory bandwidthd? in GB/s
alias browse_bonjour='dns-sd -B'							# browse services advertised via Bonjour
# alias daemons='ls /var/run/daemons'  							# daemon managment (ommited for function)
alias dbdumpcp='scp -P 1234 username@12.34.56.78:$HOME/Backup/www/data/someSite/db.sql $HOME/Backup/data/db.sql'	# copy remote db to local
alias dns='cat /etc/resolv.conf'							# view DNS numbers
alias domain2ban='~/.scripts/Domain2Ban.sh'
alias estab='ss -p | grep STA' 								# view only established sockets (fails if "ss" is screensaver alias)
alias finchsync='java -jar ~/finchsync/finchsync.jar'					# start FinchSync Admin
# alias ftop='watch -d -n 2 'df; ls -FlAt;''						# like top, but for files
alias hdinfo='hdparm -i[I] /dev/sda'							# hard disk information - model/serial no.
alias hostip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias hostname_lookup='lookupd -d'							# interactive debugging mode for lookupd (use tab-completion)
alias http_trace='pkt_trace port 80'							# to show all HTTP packets
alias iftop='sudo iftop -i eth0' 							# start "iftop" program (sudo apt-get install iftop)
alias ip4grep="grep -E '([0-9]{1,3}\.){3}[0-9]{1,3}'"					# look for IPv4 address in files
alias ip='curl www.whatismyip.org'
alias ip_info='ipconfig getpacket en1'							# info on DHCP server, router, DNS server, etc (for en0 or en1)
alias ipt80='sudo iptstate -D 80'							# check out only iptables state of http port 80 (requires iptstate)
alias ip_trace='pkt_trace ip'								# to show all IP packets
alias ipttrans='sudo iptstate -D 51413'							# iptables state of Transmission-Daemon port (requires iptstate)
alias listen='sudo netstat -pnutl' 							# lists all listening ports together with PID of associated process
alias lsock='sudo /usr/sbin/lsof -i -P'							# to display open sockets ( -P option to lsof disables port names)
alias memrel='free && sync && echo 3 > /proc/sys/vm/drop_caches && free'		# release memory used by the Linux kernel on caches
alias net1='watch --interval=2 "sudo netstat -apn -l -A inet"'
alias net2='watch --interval=2 "sudo netstat -anp --inet --inet6"'
alias net3='sudo lsof -i'
alias net4='watch --interval=2 "sudo netstat -p -e --inet --numeric-hosts"'
alias net5='watch --interval=2 "sudo netstat -tulpan"'
alias net6='sudo netstat -tulpan'
alias net7='watch --interval=2 "sudo netstat -utapen"'
alias net8='watch --interval=2 "sudo netstat -ano -l -A inet"'
alias netapps="lsof -P -i -n | cut -f 1 -d ' '| uniq | tail -n +2"
alias nethogs='sudo nethogs eth0' 							# start "nethogs" program (sudo apt-get install nethogs)
alias netl='sudo nmap -sT -O localhost'
alias netscan='sudo iwlist wlan0 scan'							# to scan your environment for available networks, do the following
alias netstats='sudo iwspy wlan0'							# if card supports it, you can collect wireless statistics by using
alias network='sudo lshw -C network' 							# view network device info
alias networkdump='sudo tcpdump not port 22' 						# dump all the network activity except ssh stuff
alias nsl='netstat -f inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2'		# show all programs connected or listening on a network port
alias ns='netstat -alnp --protocol=inet | grep -v CLOSE_WAIT | cut -c-6,21-94 | tail +2'
alias openports='sudo netstat -nape --inet' 						# view open ports
alias oports="echo 'User:      Command:   Port:'; echo '----------------------------' ; lsof -i 4 -P -n | grep -i 'listen' | awk '{print \$3, \$1, \$9}' | sed 's/ [a-z0-9\.\*]*:/ /' | sort -k 3 -n |xargs printf '%-10s %-10s %-10s\n' | uniq"	# lsof (cleaned up for just open listening ports)
alias pkt_trace='sudo tcpflow -i `active_net_iface` -c'
alias ports='lsof -i -n -P' 								# view programs using an internet connection
alias portstats='sudo netstat -s' 							# show statistics for all ports
alias ramvalue='sudo dd if=/dev/mem | cat | strings'					# will show you all the string (plain text) values in ram
alias randommac='python -c "from itertools import imap; from random import randint; print ':'.join(['%02x'%x for x in imap(lambda x:randint(0,255), range(6))])"'										# generate random valid mac addresses
alias rdp='rdesktop -u "$USER" -g 1600x1200 -D -r disk:home=/home -r clipboard:PRIMARYCLIPBOARD'	# quick full screen RDP connection
alias restartnet='sudo /etc/rc.d/network restart;sudo /etc/rc.d/wicd restart'
alias setessid='sudo iwconfig wlan0 essid network-essid'				# set the essid, which identifies the network access point you want
alias smtp_trace='pkt_trace port smtp'							# to show all SMTP packets
alias someDBdump='sudo mysqldump someDB -uroot -p > $HOME/www/_dbs/someDB.sql'
alias spavr='gtkterm -c avr'
# alias spavr='sudo chmod a=rw /dev/ttyUSB0; gtkterm -c avr'
alias spk800i='gtkterm -c k800i'
# alias spk800i='sudo chmod a=rw /dev/rfcomm0; gtkterm -c k800i'
alias syncoff='java -jar ~/Apps/FinchSync/finchsync.jar -stopserver'			# sync to PDA .. well, that'll be a sync then! - stop FinchSync SVR
alias tcpstats='sudo netstat -st' 							# show statistics for tcp ports
alias tcp_trace='pkt_trace tcp'								# to show all TCP packets
alias topsites='curl -s -O http://s3.amazonaws.com/alexa-static/top-1m.csv.zip ; unzip -q -o top-1m.csv.zip top-1m.csv ; head -1000 top-1m.csv | cut -d, -f2 | cut -d/ -f1 > topsites.txt'							# get a list of top 1000 sites from alexa
alias tproxy='ssh -ND 8118 user@server&; export LD_PRELOAD="/usr/lib/libtsocks.so"'	# creates a proxy based on tsocks
alias udpstats='sudo netstat -su' 							# show statistics for udp ports
alias udp='sudo netstat -aup' 								# list all UDP ports
alias udp_trace='pkt_trace udp'								# to show all UDP packets
alias uploads='cd /some/folder'								# access some folder
alias vncup='x11vnc -nopw -ncache 10 -display :0 -localhost'
alias website_dl='wget --random-wait -r -p -e robots=off -U mozilla "$1"'		# download an entire website
alias website_images='wget -r -l1 --no-parent -nH -nd -P/tmp -A".gif,.jpg" "$1"'	# download all images from a site
alias whois='whois -H'
alias wireless_sniffer='sudo ettercap -T -w out.pcap -i wlan0 -M ARP // //'		# sniff who are using wireless. Use wireshark to watch out.pcap
alias wscan_='iwlist scan'								# terminal network scan for wireless signals
alias wwwmirror2='wget -k -r -l ${2} ${1}'						# wwwmirror2 usage: wwwmirror2 [level] [site_url]
alias wwwmirror='wget -ErkK -np ${1}'
