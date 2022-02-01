
#uncomment below to add manual docker daemon socket setup for WSL installs
#DOCKER_DISTRO="Ubuntu"
#DOCKER_DIR=/mnt/wsl/shared-docker
#DOCKER_SOCK="$DOCKER_DIR/docker.sock"
#export DOCKER_HOST="unix://$DOCKER_SOCK"
#if [ ! -S "$DOCKER_SOCK" ]; then
#    mkdir -pm o=,ug=rwx "$DOCKER_DIR"
#    chgrp docker "$DOCKER_DIR"
#    /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.   log 2>&1"
#fi

#add /sbin to path (debian)
export PATH=$PATH:/sbin

#docker-compose
export PATH=$PATH:/usr/local/lib/docker/cli-plugins

#sane colours for directory listings
export LS_COLORS="ow=01;36;40"
export CLICOLOR=1

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

#handy shortcuts
alias h='history'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'       # Makes a more readable output.
alias df='df -kh'

#force directory listings to have colours
ls='ls --color=auto'

alias la='ls -Alh'
alias lr='ls -ltrha'
alias ll='ls -FGlAhp'

#bash editing
alias eb="vi ~/.profile"
alias sb=". ~/.profile"

 #force MacVIM usage (macOS  only)
 #alias vi="mvim -v"

alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig @resolver4.opendns.com myip.opendns.com +short"

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


eval $(thefuck --alias)

neofetch

cowsay $(fortune)
