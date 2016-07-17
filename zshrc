
# Disable PATH, or not?
#export PATH=

# Prompt
export PROMPT="%F{cyan}ovhapi%f %F{magenta}>%f "
#export PS1="\e[36movhapi \e[1m\e[35m>\e[0m\e[39m "

# Aliases
alias GET='ovhapi GET'
alias POST='ovhapi POST'
alias get=GET
alias g=GET
alias post=POST
alias p=POST

# Functions
source /usr/local/bin/__ovh_functions.sh

echo
echo "   Hello $(GET /me | jq -r .firstname)!"
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


