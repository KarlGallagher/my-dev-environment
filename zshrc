eval "$(starship init zsh)"

eval $(thefuck --alias)

neofetch

cowsay $(fortune)

 alias kubectl='minikube kubectl --'

 alias mv='mv -i' # Prevents accidentally clobbering files.

  #handy shortcuts
 alias h='history'
 alias path='echo -e ${PATH//:/\\n}'
 alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

 alias du='du -kh'       # Makes a more readable output.
 alias df='df -kh'

 #bash editing
 alias eb="vi ~/.zshrc"
 alias sb=". ~/.zshrc"

 #force MacVIM usage
 alias vi="mvim -v"

 alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
 alias myip="dig @resolver4.opendns.com myip.opendns.com +short"

 #reverse file read
 alias tac='tail -r'

 man()
 {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
 }