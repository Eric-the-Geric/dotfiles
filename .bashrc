#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
export PATH="$HOME/bin:$PATH"
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

my_t="[\e[1;33m\t\e[01;37m]"
my_u="[\[\e[1;34m\u\e[01;37m\]]"
my_h="[\[\e[00;37m\]${HOSTNAME%%.*}\[\e[01;37m\]]"
my_w="$\[\e[01;31m\]\w\[\e[01;37m\]"
my_n="$\[\e[01;31m\]\n\[\e[01;37m\]"
#export PS1="\[\e[01;37m\]┌─${my_t}──${my_u}──${my_h}:${my_w}${my_n}└──\[\e[01;37m\]>>\[\e[0m\]"
export PS1="${blu}┌─${wht}${my_t}──${my_u}──${my_h}:${my_w}${my_n}${blu}└──${blu}>>\[\e[0m\]"

# Keep machine paths, environment managers, and secrets outside Git.
if [[ -r $HOME/.config/dotfiles/local.bash ]]; then
    source "$HOME/.config/dotfiles/local.bash"
fi
