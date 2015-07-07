
#-------------------------------------------------------------
# PATH & other env variables
#-------------------------------------------------------------

## rbenv
#export PATH=$HOME/.rbenv/bin:$PATH
#eval "$(rbenv init -)"
#PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH
#PATH=$HOME/.rbenv/shims:$PATH                       # for binaries
#export GEM_PATH=$HOME/.rbenv/shims
#export GEM_HOME=$GEM_PATH

# Ruby (and RVM for version management)
PATH=$PATH:$HOME/.rvm/bin
PATH=$HOME/.rvm/gems/ruby-1.9.3-p545/bin:$PATH      # Ruby's bin dir.

# IntelliJ (and Java, log4j)
export JAVA_HOME=/usr/lib/jvm/default-java          # point to Java JDK, rather than JRE, for IntelliJ
PATH=$PATH:${JAVA_HOME}/bin
export CLASSPATH=$CLASSPATH:/opt/apache-log4j-1.2.17/log4j-1.2.17.jar           # log4j
PATH=$PATH:/opt/apache-log4j-1.2.17/
PATH=/opt/idea/bin:$PATH                            # for IntelliJ

# Misc.
PATH=/usr/bin/ctags-exuberant:$PATH                 # ctags...
PATH=$PATH:/usr/bin/nodejs                          # node.js
PATH=/usr/local/Qt-5.4.2/bin/:$PATH                 # Qt (Qt5)

# Finally, 'export' PATH; after adding ~/bin & ~/scripts
export PATH=$PATH:$HOME/bin:$HOME/scripts

#-------------------------------------------------------------
# Shell (Settings/Installs/Configs/other major aliases/fns)
#-------------------------------------------------------------

stty -ixon                                          # ignore suspend (CTRL-s) / resume (CTRL-q)
set -o noclobber
set -o vi                                           # use vi to edit cmnd line

alias sag='sudo apt-get'
alias pkgs='sudo dpkg --get-selections'

alias b='vi $HOME/.bashrc'
alias v='vi $HOME/.vimrc'
alias dotfiles='ls -1d .??* | \grep "[^/]$"'
alias dotdirs='ls -1d .??*/'
alias thedirs='ls -1d */'

alias ..='cd ..'
alias cls=clear
alias clsa='clear; lsa'
alias rm='rm -i --preserve-root'
alias cp='cp -i'
alias mv='mv -i'  # to prevent accidentally clobbering files
alias which='type -a'
alias top=atop
alias j='jobs -l'
alias du='du -kh' # makes a more readable output
alias df='df -kTh'

alias rp='echo "USE SINGLE-QUOTE & CTRL-V. ---> perl -ne \"next LINE unless / Load \(|SELECT COUNT/; s/^[\[[0-9;]*[a-zA-Z]//g; s/ Load \([0-9]{1,3}\.[0-9]ms\) /:/;s/ \([0-9]{1,3}\.[0-9]ms\) /:/; print $_ \" FILE | sort"'
#alias python=python3
alias python=python2                                # using python2 for Base Extractor

alias dog='pygmentize -g'                           # 'cat' with COLOR !
alias cnv=dos2unix                                  # USAGE: cnv <file>.  Directing to o/p does not work here; the <file> is changed "in place"

# An alternative Pager - using Vim
alias vil='/usr/share/vim/vim74/macros/less.sh'
# Nice alternative to recursive 'ls'
#alias trees='tree -Csuh'

# Pretty-print PATH related env. variables
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

psa() {
  ps aux | grep -i $*
}

#-------------------------------------------------------------
# Dev/Apps related
#-------------------------------------------------------------

# PostgreSQL
alias psql='psql xras xras' # (on localhost)
alias sudop='sudo su postgres'
pgd() { # arg_1 --> Source-DB (eg: xras_test_xdcdb); arg_2 --> Source-Schema (eg: xras); arg_3 --> DB-User (eg: postgres)
  pg_dump -h sybase2.ncsa.uiuc.edu -U ${3} -d ${1} -n ${2} -Fc -f `date +%Y%m%d`.${1}.${2}.${3}.backup --exclude-table-data=action_documents
}
# For pgr:  REMEMBER to 1st CREATE an empty Destination-DB, along w/a Schema!
pgr() {  # arg_1 --> Dest-DB; arg_2 --> Dest-Schema; arg_3 --> DB-User; arg_4 --> input file (eg: 20140624.xras_test_xdcdb.xras.postgres.backup)
  pg_restore -h localhost -U ${3} -d ${1} -n ${2} ${4} 2>&1 | tee out/${4}.RESTORE_AS.${1}.out
}

# Ruby / Rails
alias rux='rvm use 1.9.3-p545@xras-dev --default'

rgc() {
  rvm gemset create $1
}
alias rin='rvm info'
alias rgl='rvm gemset list'                     # [there's also 'rvm list']
alias bli='bundle list'
alias gl='gem list | less'
un() { # eg:  un actionpack '<3.2.19'
  gem uninstall ${1} --version ${2};
}

alias bi='bundle install'
alias rake='bundle exec rake'

alias lsg='lsa $HOME/.rvm/gems/ruby-1.9.3-p545'
alias cdg='cd $HOME/.rvm/gems/ruby-1.9.3-p545'
alias psr='ps aux | grep rail'

# in development_local:
alias rrl='RAILS_ENV=development_local rake routes'
alias rcl='rails console development_local -s'
alias rdl='rails db development_local'               # (psql)
# -- logs
alias rlz='truncate -s0 $XRAS_ADMIN_ROOT/log/development_local.log'
alias rlc='wc -l $XRAS_ADMIN_ROOT/log/development_local.log'
alias rlt="grc tail -f $XRAS_ADMIN_ROOT/log/development_local.log | perl -pi -e 's/(Processing by [a-zA-Z0-9]+sController#[a-z0-9_]+)/\007\033[31;1m\1 \033[0m/'"
alias rlg="grep -n ' Load (' $XRAS_ADMIN_ROOT/log/development_local.log |sort -b -k2"
# Strip ESC characters (used for colors), etc., from the Rails log (say):
alias strp='sed -r "s!\x1B\[([0-9]{1,2}(;[0-9]{1,2})*)?m!!g"'

# for XRAS Admin:
alias rsx='rails server -e development_local'
alias rsxd='rails server -e development_local -d'
# for XRAS Rules (Engine) Service:
alias rsr='RAILS_ENV=development rails server -e development -p3333'
alias rsrd='RAILS_ENV=development rails server -e development -p3333 -d'
# for XRAS Accounting (API) Service:
alias rsa='RAILS_ENV=testing rails server -e testing -p3330'
alias rsad='RAILS_ENV=testing rails server -e testing -p3330 -d'

# Clowder
alias cds='cd $HOME/dev_isda/sead'
export CLOWDER_ROOT=$HOME/dev_isda/sead/clowder
alias cdc='cd $CLOWDER_ROOT'

alias ctm='cd $CLOWDER_ROOT; ctags -h[".scala"] -R -f ./.git/tags .'

alias pss='psa sbt'

alias rel='elasticsearch-1.5.1/bin/elasticsearch -Dlog4j.configuration=$HOME/log4j.properties -d 2>&1'
alias elastic='curl -X GET http://localhost:9200'

#-------------------------------------------------------------
# g\Vim
#-------------------------------------------------------------

export VIM=/usr/share/vim/vim74
##export VIMRUNTIME=...
alias vi='/usr/bin/gvim "+colo sahara"'
alias maps="grep -A1 map $HOME/.vimrc | sed '/[>my]$/{N;s!\n!!}' | grep map | sed -r 's!^.+\" !  !; s!^  (.*) <--!$(tput setaf 2)  \1  $(tput sgr0)<--!; s!<-- (.*)!<---- $(tput setaf 6) \1$(tput sgr0)!'"
export EDITOR=vim

#-------------------------------------------------------------
# diff & Related
#-------------------------------------------------------------

alias dif='colordiff -bw'
alias difi='colordiff -bwi'
alias diff='colordiff'
didi() {
  dirdiff $1 $2 &
}
alias difs='diff -bWiEZ -w350 --diff-program=colordiff'

komp() {
  kompare $* 2>/dev/null &
}
alias difg='gvim -d'

#-------------------------------------------------------------
# Git
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

alias gdus.h='git diff HEAD'         # `Git `Diff   `Unstaged OR `Staged   cf`.   `Head              [Unstaged|<      ...]
alias gdu.sh='git diff'              # `Git `Diff   `Unstaged              cf`.   `Staged OR HEAD    [...        Staged|<]
alias gds.h='git diff --cached'      # `Git `Diff   `Staged                cf`.   `Head              ["Cached" === Staged]
alias gdh.p='git diff HEAD^ HEAD'    # `Git `Diff   `HEAD                  cf`.   `Previous Head
# Below: Same as above, but with 'git difftool' (rather than 'git diff')
alias gtus.h='git difftool HEAD 2>/dev/null'
alias gtu.sh='git difftool 2>/dev/null'
alias gts.h='git difftool --cached 2>/dev/null'
alias gth.p='git difftool HEAD^ HEAD 2>/dev/null'

# Clowder:
gic() { # arg_1 --> name[.git] (eg: clowder.git)
  git clone https://jansz@opensource.ncsa.illinois.edu/stash/scm/cats/${1}
}
alias gpfs='git pull origin/feature/spaces'
gigb() {
  /usr/lib/git-core/git-gui blame $* 2>/dev/null &
}

## To override user.name/.email set in .gitconfig
#export GIT_AUTHOR_NAME='Winston Jansz'
#export GIT_COMMITTER_NAME='Winston Jansz'
#export GIT_AUTHOR_EMAIL='jansz@illinois.edu'
#export GIT_COMMITTER_EMAIL='jansz@illinois.edu'

#-------------------------------------------------------------
# grep/find
#-------------------------------------------------------------

alias grep='grep --color=auto'
# Pipe grep's output thru 'less', etc., but STILL preserve search string colorization:
alias grpa='\grep --color=always'
grp() {
  grep $* 2>/dev/null
}
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
g4ds() {
  grep -i $* $HOME/.{bash_logout,bashrc,bash_profile,profile,vimrc} $HOME/scripts/{stx,rsun}.sh
}

alias fr='find . -type d \( -name .git -o -name .idea -o -name doc -o -name log -o -name test -o -name tmp -o -name public -o -name script -o -name scripts -o -name target \) -prune -o -name'
alias frj='find . -type d \( -name javascripts -name .git -o -name doc -o -name log -o -name test -o -name tmp \) -prune -o -name'
alias rfr='echo "fr \"*\" | grep -v \"\./tags:\" | xargs grep -in --color=always \"STRS\" 2>/dev/null"'
alias rfr2='echo "fr \"*\" | grep -v \"\./tags:\" | xargs grep -v xras_summary 2>/dev/null | grep -in --color=always \"STRS\""'

#-------------------------------------------------------------
# ls
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

#-------------------------------------------------------------
# less
#-------------------------------------------------------------

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
# Print
#-------------------------------------------------------------

alias ens7pd='enscript --color --mark-wrapped-lines=arrow -GC -DDuplex:true -Eruby -fCourier7 --style=a2ps'
alias ens7ld='enscript --color --mark-wrapped-lines=arrow -rGC -DDuplex:true -Eruby -fCourier7 --style=a2ps'
alias ens7l2d='enscript --color --mark-wrapped-lines=arrow -2rjGC -DDuplex:true -Eruby -fCourier7 --style=a2ps'
alias ens9pd='enscript --color --mark-wrapped-lines=arrow -GC -DDuplex:true -Eruby -fCourier9 --style=a2ps'
alias ens9pn='enscript --color --mark-wrapped-lines=arrow -GC -DDuplex:false -Eruby -fCourier9 --style=a2ps'
alias ens9ld='enscript --color --mark-wrapped-lines=arrow -rGC -DDuplex:true -Eruby -fCourier9 --style=a2ps'
alias ens9ln='enscript --color --mark-wrapped-lines=arrow -rGC -DDuplex:false -Eruby -fCourier9 --style=a2ps'

#-------------------------------------------------------------
# VM
#-------------------------------------------------------------

alias rxv='mv /mnt/hgfs/iShared/* .'
txv() { # arg_1[,..] --> filename[s] (eg: abc pqr xyz.txt)
  cp -pr $* /mnt/hgfs/iShared/
}

#-------------------------------------------------------------
# Other misc aliases/fns
#-------------------------------------------------------------

function my_ip() { # Get IP adress on ethernet
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii() { # Get current host, & related, info
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

#-------------------------------------------------------------
# Prompt
#-------------------------------------------------------------

export PS1='\[\e[1;33m\]\w $ \[\e[m\]'

#-------------------------------------------------------------
# Title bar
#-------------------------------------------------------------

function git-branch-name() {
  git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f3-
}

function git-branch-prompt {
  local branch=$(git-branch-name)
  if [ $branch ]; then
    printf " [%s]     " $branch
  fi
}

function tb() {
  local dir="$PWD"
  if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
    dir="~${dir:${#HOME}}" # use '~' if possible
  fi
  echo -ne "\e]0;$(git-branch-prompt)${dir}\007"
}
export PROMPT_COMMAND=tb

