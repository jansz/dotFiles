
#-------------------------------------------------------------
# PATH & other environment variables / rbenv
#-------------------------------------------------------------

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

#PATH=$PATH:$HOME/.rvm/bin                           # Add RVM, for scripting
PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH
PATH=$HOME/.rbenv/shims:$PATH                       # for binaries

#PATH=$HOME/.rvm/gems/ruby-1.9.3-p545/bin:$PATH      # Ruby's bin dir.
#export GEM_PATH=$HOME/.rbenv/shims
#export GEM_HOME=$GEM_PATH

export JAVA_HOME=/usr/lib/jvm/default-java
PATH=$PATH:${JAVA_HOME}/bin

export CLASSPATH=$CLASSPATH:/opt/apache-log4j-1.2.17/log4j-1.2.17.jar
PATH=$PATH:/opt/apache-log4j-1.2.17/

export VIM=/usr/share/vim/vim74
#export VIMRUNTIME=...

PATH=/usr/bin/ctags-exuberant:$PATH
PATH=$PATH:/usr/bin/nodejs                          # add node.js

export PATH=$PATH:$HOME/bin:$HOME/scripts

#-------------------------------------------------------------
# Settings
#-------------------------------------------------------------

stty -ixon                                          # ignore suspend (CTRL-s) / resume (CTRL-q)
#set -o noclobber
set -o vi                                           # use vi to edit cmnd line

export EDITOR=vim

alias vi='/usr/bin/gvim "+colo sahara"'
alias difg='gvim -d'
#alias sudop='sudo su postgres'

#-------------------------------------------------------------
# Dirs
#-------------------------------------------------------------

alias cdd='cd $HOME/dev/sead'
export SEAD_MEDICI_ROOT=$HOME/dev/sead/medici-play
alias cdm='cd $SEAD_MEDICI_ROOT'

#-------------------------------------------------------------
# Aliases/Fns - Git
#-------------------------------------------------------------

alias gis='git status'                              # 'GI't 'S'tatus

alias gil='git log'                                 # 'GI't 'L'og
alias gilsh='git shortlog'                          # <git log> 'SH'ort log
alias gig='git log --graph --all --oneline --date=local --format="%<(10,trunc)%h %Cblue%<(80,trunc)%s %Cgreen%<(12,trunc)%ai %Creset%<(10,trunc)%an %Cred%d"'
alias giga='git log --graph --decorate --pretty=oneline --abbrev-commit --date=local'
alias gigs='gig --stat'

alias gilfl='git log --name-status'                 # <git log> - changes - 'F'i'L'es list
alias gilst='git log --stat'                        # <git log> - changes - 'ST'ats

gign() {
  git update-index --assume-unchanged $*
}                                                   # 'G'it 'IGN'ore
gignun() {
  git update-index --no-assume-unchanged $*
}                                                   # <gign> 'UN'do
alias gignd='git ls-files -v | grep "^[[:lower:]]"' # <gign>e'D'

alias gib='git branch -a'                           # 'GI't 'B'ranch
alias gibl='git branch | grep -v remote'            # <gib> on 'L'ocal repo
alias gibr='git branch -r'                          # <gib> on 'R'emote repo

alias gidh='git diff HEAD'                          # 'GI't 'D'iff: current cf 'H'ead
alias gidhp='git diff HEAD^ HEAD'                   # 'GI't 'D'iff: 'H'ead cf 'P'revious-to-head

gic() { # arg_1 --> name[.git] (eg: medici-play.git)
  git clone https://opensource.ncsa.illinois.edu/stash/scm/mmdb/${1}
}

alias gion1='git rebase --onto'                     # 'GI't rebase 'ON'to - step '1' (of 2)

# To override user.name/.email set in .gitconfig (since $USER is 'wnj'):
export GIT_AUTHOR_NAME='Winston Jansz'
export GIT_COMMITTER_NAME='Winston Jansz'
export GIT_AUTHOR_EMAIL='jansz@illinois.edu'
export GIT_COMMITTER_EMAIL='jansz@illinois.edu'

#-------------------------------------------------------------
# Aliases/Fns - Others
#-------------------------------------------------------------

alias ..='cd ..'

alias sag='sudo apt-get'
alias pkgs='sudo dpkg --get-selections'

alias b='vi $HOME/.bashrc'
alias v='vi $HOME/.vimrc'

#alias python=python3
alias python=python2                                # using python2 for Base Extractor
alias cnv=dos2unix                                  # USAGE: cnv <file>.  Directing to o/p does not work here; the <file> is changed "in place"
alias dog='pygmentize -g'                           # 'cat' with COLOR !

alias rxv='mv /mnt/hgfs/iShared/* .'
txv() { # arg_1[,..] --> filename[s] (eg: abc pqr xyz.txt)
  cp -pr $* /mnt/hgfs/iShared/
}

alias dif='colordiff -bw'
alias difi='colordiff -bwi'
alias diff='colordiff'
didi() {
  dirdiff $1 $2 &
}

alias grep='grep --color=auto'
# Pipe grep's output thru 'less', etc., but STILL preserve search string colorization:
alias grpa='\grep --color=always'
grp() {
  grep $* 2>/dev/null
}
# Strip ESC characters (used for colors), etc., from the Rails log (say):
alias strp='sed -r "s!\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?m!!g"'

g4b() {
  grep -i $* $HOME/.bashrc
}
g4b1() {
  grep -i -B1 -A1 $* $HOME/.bashrc
}
g4b2() {
  grep -i -B2 -A2 $* $HOME/.bashrc
}
g4bh() {
  grep -i $* $HOME/.ebh
}
g4d() {
  grep -i $* $HOME/.{bash_logout,bashrc,bash_profile,profile,vimrc}
}
#g4ds() {
#  grep -i $* $HOME/.{bash_logout,bashrc,bash_profile,profile,vimrc} $HOME/scripts/{stx,rsun}.sh
#}

alias maps="grep -A1 map $HOME/.vimrc | sed '/[>my]$/{N;s!\n!!}' | grep map | sed -r 's!^.+\" !  !; s!^  (.*) <--!$(tput setaf 2)  \1  $(tput sgr0)<--!; s!<-- (.*)!<---- $(tput setaf 6) \1$(tput sgr0)!'"

alias dotfiles='ls -1d .??* | \grep "[^/]$"'
alias dotdirs='ls -1d .??*/'
alias thedirs='ls -1d */'

alias fr='find . -type d \( -name .git -o -name doc -o -name log -o -name test -o -name tmp \) -prune -o -name'
alias frj='find . -type d \( -name javascripts -name .git -o -name doc -o -name log -o -name test -o -name tmp \) -prune -o -name'
alias rfr='echo "fr \"*\" | grep -v \"\./tags:\" | xargs grep -in --color=always \"WORDS\" 2>/dev/null"'
alias rp='echo "USE SINGLE-QUOTE & CTRL-V. ---> perl -ne \"next LINE unless / Load \(|SELECT COUNT/; s/^[\[[0-9;]*[a-zA-Z]//g; s/ Load \([0-9]{1,3}\.[0-9]ms\) /:/;s/ \([0-9]{1,3}\.[0-9]ms\) /:/; print $_ \" FILE | sort"'

alias ctm='cdm; ctags -h[".scala"] -R -f ./.git/tags .'

alias cls=clear
alias clsa='clear; lsa'
alias which='type -a'
alias j='jobs -l'
alias top=atop
alias du='du -kh' # makes a more readable output
alias df='df -kTh'

alias rm='rm -i --preserve-root'
alias cp='cp -i'
alias mv='mv -i'  # to prevent accidentally clobbering files

# Pretty-print some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

#-------------------------------------------------------------
# Aliases/Fns - apps
#-------------------------------------------------------------

psa() {
  ps aux | grep -i $*
}
alias pss='psa sbt'
alias rel='elasticsearch-1.5.1/bin/elasticsearch -Dlog4j.configuration=$HOME/log4j.properties -d 2>&1'
alias elastic='curl -X GET http://localhost:9200'

#-------------------------------------------------------------
# History
#-------------------------------------------------------------

alias h=history
alias hl='history | less'
alias hi='history| sort -k 2.1,3'
alias hir='history| sort -r -k 2.1,3'

export HISTFILESIZE=50000       # num. lines allowed in hist. file (on disk) at session startup; & stored in hist. file at end of session, for future
# (use: export HISTFILESIZE=    ; for eternal bash history--an undocumented feature; sets size to "unlimited")
export HISTSIZE=10000           # num. lines stored in memory (not disk) during curr. session
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=$HOME/.ebh      # change file location because certain bash sessions truncate .bash_history upon close
#shopt -s histappend            # append curr. session's hist. to hist. file, on closing current session, rather than overwriting

#-------------------------------------------------------------
# The 'ls' family
#-------------------------------------------------------------

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -hF --color=auto'

alias lx='ls -lXB'              # Sort by extension.
alias lk='ls -lSr'              # Sort by size, biggest last.
alias lsa='ls -A'               # Show hidden files (excluding ./ and ../ dirs)
alias lt='ls -ltrA'             # Sort by date, most recent last.
alias lc='ls -ltcr'             # Sort by/show change time,most recent last.
alias lu='ls -ltur'             # Sort by/show access time,most recent last.

alias lsac='lsa *'              # Contents of child-dirs.
alias lsag='lsa */*'            # Contents of grandchild-dirs.

# The ubiquitous 'll'; directories first, with alphanumeric sorting:
alias ll='ls -lv --group-directories-first'

alias lm='ll |more'             #  Pipe through 'more'
alias lr='ll -R'                #  Recursive ls.
alias la='ll -A'                #  Show hidden files, excluding . and ..

# A nice alternative to recursive-'ls':
#alias trees='tree -Csuh'

#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

# An alternative Pager - using Vim ! :
alias vil='/usr/share/vim/vim74/macros/less.sh'

alias l='less -R'
alias more=l

export PAGER=less
#export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # use this if lesspipe exists
#export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes 'man' pages more readable):
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#-------------------------------------------------------------
# Printing
#-------------------------------------------------------------

alias ens7pd='enscript --color --mark-wrapped-lines=arrow -GC -DDuplex:true -Eruby -fCourier7 --style=a2ps'
alias ens7ld='enscript --color --mark-wrapped-lines=arrow -rGC -DDuplex:true -Eruby -fCourier7 --style=a2ps'
alias ens7l2d='enscript --color --mark-wrapped-lines=arrow -2rjGC -DDuplex:true -Eruby -fCourier7 --style=a2ps'
alias ens9pd='enscript --color --mark-wrapped-lines=arrow -GC -DDuplex:true -Eruby -fCourier9 --style=a2ps'
alias ens9pn='enscript --color --mark-wrapped-lines=arrow -GC -DDuplex:false -Eruby -fCourier9 --style=a2ps'
alias ens9ld='enscript --color --mark-wrapped-lines=arrow -rGC -DDuplex:true -Eruby -fCourier9 --style=a2ps'
alias ens9ln='enscript --color --mark-wrapped-lines=arrow -rGC -DDuplex:false -Eruby -fCourier9 --style=a2ps'

#-------------------------------------------------------------
# Prompt
#-------------------------------------------------------------

export PS1="\[\007\033[35;22m\]\w\[\033[31;1m\] \$ \[\033[0m\]"

#-------------------------------------------------------------
# Titlebar
#-------------------------------------------------------------

function git-branch-name() {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f3-
}

function git-branch-prompt {
  local branch=$(git-branch-name)
  if [ $branch ]; then
    printf "[%s]   : " $branch
  fi
}

function tb() {
  local dir="$PWD"
  if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
    dir="~${dir:${#HOME}}" # use '~' if possible
  fi
  if [[ ${dir:${#dir}-1} != "/" ]] ; then
    dir="$dir/" # add trailing '/' if necessary
  fi
  echo -ne "\033]0;$(git-branch-prompt)${dir}\007"
}
export PROMPT_COMMAND=tb

#-------------------------------------------------------------
# Process/system related fns:
#-------------------------------------------------------------

function my_ip() { # Get IP adress on ethernet.
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii() { # Get current host related info.
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; df -kTh / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}
