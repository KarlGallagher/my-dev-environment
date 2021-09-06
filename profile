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

serve() 
{ 
    python -m SimpleHTTPServer ${1:-8090} 
}


getChangedFiles()
{
	cat $1 | grep +++ | awk -F / {'print $11'} | awk -F \( {'print $1'}
}

dumphex()
{
	xxd -plain $1 | tr -d '\n'
}


### Usefull Aliases ###

alias kubectl='minikube kubectl --'

alias mv='mv -i' # Prevents accidentally clobbering files.

alias free='top -o vsize'
alias ltop='top -F -R -o cpu'

#handy shortcuts
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'       # Makes a more readable output.
alias df='df -kh'

#listing files
alias ll='ls -lh'
alias la='ls -Alh'
alias lr='ls -ltrh'
alias ls='ls -ltrGFh'

#bash editing
alias eb="vi ~/.profile"
alias sb=". ~/.profile"

#force MacVIM usage
#alias vi="mvim -v"
alias evim='vi ~/.vimrc' 

alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"

#reverse file read
alias tac='tail -r'


genpass()
{
    uuidgen | base64 | tee ~/.pass
}
addpath()
{
    export PATH=$PATH:$1
}

addlibpath()
{
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$1
}

check_min_ios_sdk()
{
	otool -l  $1 |  fgrep --after-context=3 LC_VERSION_MIN_IPHONEOS | grep $2
}

check_ios_archs()
{
    otool -hv -arch all $1
}

ssh_xterm()
{
    export DISPLAY=:0
    ssh -Y $1
}

scarlett()
{
    echo "USADXBFLJFMCSPSV"
}

eval $(thefuck --alias)

neofetch

cowsay $(fortune)
