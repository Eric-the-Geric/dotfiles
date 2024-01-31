#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
PS1='[\u@\h \W]\$ '

blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset
echo

printf "\033[0m
    \033[49;35m|\033[49;31m|\033[101;31m|\033[41;97m|\033[49;91m|\033[49;93m|\033[0m
  \033[105;35m|\033[45;97m|\033[49;97m||\033[100;97m||\033[49;37m||\033[103;33m|\033[43;97m|\033[0m
  \033[49;95m|\033[49;94m|\033[100;37m||\033[40;97m||\033[40;37m||\033[49;33m|\033[49;32m|\033[0m
  \033[104;34m|\033[44;97m|\033[49;90m||\033[40;39m||\033[49;39m||\033[102;32m|\033[42;97m|\033[0m
    \033[49;34m|\033[49;36m|\033[106;36m|\033[46;97m|\033[49;96m|\033[49;92m|\033[0m

"

my_t="[\e[1;33m\t\e[01;37m]"
my_u="[\[\e[1;34m\u\e[01;37m\]]"
my_h="[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;37m\]]"
my_w="$\[\e[01;31m\]\w\[\e[01;37m\]"
my_n="$\[\e[01;31m\]\n\[\e[01;37m\]"
export PS1="\[\e[01;37m\]┌─${my_t}──${my_u}──${my_h}:${my_w}${my_n}└──\[\e[01;37m\]>>\[\e[0m\]"





# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/eric/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/eric/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/eric/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/eric/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi


if command -v pyenv 1>/dev/null 2>&1; then
                         eval "$(pyenv init -)"
                      fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
