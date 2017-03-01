
ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="pure-thb"

#CASE_SENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
COMPLETION_WAITING_DOTS="true"

plugins=(history-substring-search)
source $ZSH/oh-my-zsh.sh

# Prompt
export PROMPT="%F{cyan}ovhapi%f %F{magenta}>%f "

# Aliases
alias GET='ovhapi GET'
alias POST='ovhapi POST'
alias get=GET
alias g=GET
alias post=POST
alias p=POST

# Strict PATH
#export PATH=$(which jq):$(which ovhapi)

# Functions
source /usr/local/bin/__ovh_functions.sh

clear
echo
echo Loading...
firstname=$(GET /me | jq -r .firstname)
clear
echo
echo "   Hello $firstname!"
echo

# while read cmd; do
#   cmd=$(/bin/sed "s/enable -n //" <<< $cmd)
#   [[ "$cmd" == "enable -n" ]] && continue
#   enable -n -n $cmd
# done < <(enable -n)

# __list_endpoints() {
# echo '/me'
# /cloud/project'
# ...
# TBC'
# }

# _list_endpoints() {
#   while read m
#   do
#     compadd "$m"
#   done < <(__list_endpoints)
#   return 0
# }
# Autocomplete dme/dmes aliases with docker machines
#compdef __list_endpoints GET
#compdef __list_endpoints POST

# Disable bash builtin commands
# enable -n .
# enable -n :
# enable -n [
# enable -n alias
# enable -n bg
# enable -n bind
# enable -n break
# enable -n builtin
# enable -n caller
# enable -n cd
# enable -n command
# enable -n compgen
# enable -n complete
# enable -n compopt
# enable -n continue
# enable -n declare
# enable -n dirs
# enable -n disown
# enable -n echo
# enable -n eval
# enable -n exec
# enable -n exit
# enable -n export
# enable -n false
# enable -n fc
# enable -n fg
# enable -n getopts
# enable -n hash
# enable -n help
# enable -n history
# enable -n jobs
# enable -n kill
# enable -n let
# enable -n local
# enable -n logout
# enable -n mapfile
# enable -n popd
# enable -n printf
# enable -n pushd
# enable -n pwd
# enable -n read
# enable -n readarray
# enable -n readonly
# enable -n return
# enable -n set
# enable -n shift
# enable -n shopt
# enable -n source
# enable -n suspend
# enable -n test
# enable -n times
# enable -n trap
# enable -n true
# enable -n type
# enable -n typeset
# enable -n ulimit
# enable -n umask
# enable -n unalias
# enable -n unset
# enable -n wait
# enable -n enable


[ -f ~/.myzshrc ] && source ~/.myzshrc