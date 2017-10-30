if [ -z "$TMUX" ] && [ -n "$SSH_TTY" ]; then
      tmux attach-session -t ssh || tmux new-session -s ssh
          exit
        fi
autoload -Uz compinit promptinit colors add-zsh-hook
compinit
promptinit
colors

setopt always_to_end
setopt no_case_glob
setopt complete_in_word
setopt completealiases
setopt autocd
setopt correct
setopt extendedglob
setopt numericglobsort
setopt auto_param_slash
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt prompt_subst

#source ~/.zsh/zsh-git-prompt/zshrc.sh

# Default values for the appearance of the prompt. Configure at will.
#ZSH_THEME_GIT_PROMPT_PREFIX=" "
#ZSH_THEME_GIT_PROMPT_SUFFIX=""
#ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
#ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
#ZSH_THEME_GIT_PROMPT_REMOTE=""
#if [ "$TERM" = "linux" ]; then
#    ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}s"
#    ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}x"
#    ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}+"
#    ZSH_THEME_GIT_PROMPT_UNTRACKED="..."
#    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}o"
#else
#    ZSH_THEME_GIT_PROMPTalias verynice="ionice -c3 nice -n 15"_STAGED="%{$fg[red]%}●"
#    ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖"
#    ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}✚"
#    ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
#    ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"
#fi

export HISTFILE="${HOME}"/.zsh-history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE

export PAGER=/bin/vimpager
alias less=$PAGER
alias zless=$PAGER 

source /etc/profile

export PATH="$PATH:$HOME/.bin:$HOME/.powerline/scripts"

# ruby gems
export PATH="$PATH:$HOME/.gem/ruby/2.0.0/bin"

precmd() {
    [[ $history[$[ HISTCMD -1 ]] == *(pacmatic)* ]] && rehash
}

[ -e ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -e /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# platform-specific settings (modified locally)
[ -e ~/.zsh/platform-specific.zsh ] && source ~/.zsh/platform-specific.zsh

eval `dircolors $HOME/.dir_colors/dircolors-solarized/dircolors.256dark`

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _global_ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/config ] && _ssh_config=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p')) || _ssh_config=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
"$_ssh_config[@]"
"$_global_ssh_hosts[@]"
"$_ssh_hosts[@]"
# "$_etc_hosts[@]"
"$HOST"
localhost
)

zstyle ':completion:*:hosts' hosts $hosts
zstyle ':completion:*' users off

[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

[ -e $HOME/.zsh/notifyosd.zsh ] && [ -e /usr/bin/notify-send ] && . $HOME/.zsh/notifyosd.zsh

if [ "$TERM" = "linux" ]; then
    PROMPT="▶ "
else
  PROMPT='%(?.➤.%{$fg[red]%}➤%{$reset_color%}) '
fi

#RPROMPT='[%{%(!.$fg[red].$fg[blue])%}%2~%{$reset_color%}$(git_super_status)]'
RPROMPT='[%{%(!.$fg[red].$fg[blue])%}%2~%{$reset_color%}]'
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    RPROMPT='[%{$fg[green]%}$HOST%{$reset_color%}]'$RPROMPT
fi

expand-or-complete-with-dots() {
    echo -n "\e[31m...\e[0m"
    zle expand-or-complete
    zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"  ]]  && bindkey  "${key[Home]}"  beginning-of-line
[[ -n "${key[End]}"   ]]  && bindkey  "${key[End]}"   end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"  ]]  && bindkey  "${key[Up]}"  history-beginning-search-backward
[[ -n "${key[Down]}"  ]]  && bindkey  "${key[Down]}"  history-beginning-search-forward
[[ -n "${key[Left]}"  ]]  && bindkey  "${key[Left]}"  backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
    printf '%s' ${terminfo[smkx]}
}
function zle-line-finish () {
printf '%s' ${terminfo[rmkx]}
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

alias extract='atool -x '
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

conf() {
    case $1 in
        conky)  vim ~/.conkyrc ;;
        pacman)   sudo vim /etc/pacman.conf ;;
        vim)  vim ~/.vimrc ;;
        xinit)  vim ~/.xinitrc ;;
        xresources) vim ~/.Xresources && xrdb ~/.Xresources ;;
        zsh)  vim ~/.zshrc && source ~/.zshrc ;;
        i3)   vim ~/.i3/config && i3-msg reload;;
        compton)  vim ~/.compton.conf ;;
        mutt)   vim ~/.muttrc ;;
        dunst)   vim ~/.dunstrc && killall dunst && dunst -conf ~/.dunstrc ;;
        *)  echo "Unknown application: $1" ;;
    esac
}

alias ls='ls --color'
[ -e /usr/bin/colordiff ] && alias diff='colordiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias copy='rsync -zvaP --progress '

if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
fi

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'


if [ -e /usr/bin/pacaur ]; then INSTALLER="pacaur"; else INSTALLER="pacman"; fi
if [ -e /usr/bin/pacmatic ]; then PACMAN="pacmatic"; else PACMAN="pacman"; fi
if [ -e /usr/bin/powerpill ]; then export pacman_program="powerpill"; fi

if [ -e /usr/bin/pacman ]; then
    alias pac="/usr/bin/${INSTALLER} -S"
    pacu() {
        sudo -E $PACMAN -Syu
        if [ -e /usr/bin/pacaur ]; then pacaur -Sua ; fi
        sudo -E $PACMAN -Rs $(pacman -Qtdq)
    }
    alias pacuq="/usr/bin/${INSTALLER} -Syu --noconfirm"
    alias pacr="sudo -E /usr/bin/${PACMAN} -Rs"
    alias pacrem="sudo -E /usr/bin/${PACMAN} -Rns"
    alias pacs="/usr/bin/${INSTALLER} -Ss"
    alias paci="/usr/bin/${INSTALLER} -Si"
    alias pacins="sudo -E /usr/bin/${PACMAN} -U"
    alias paclo="/usr/bin/${PACMAN} -Qdt"
    alias pacc="sudo -E /usr/bin/${PACMAN} -Scc"
    alias paclf="/usr/bin/${PACMAN} -Ql"
    alias pacexpl="sudo -E /usr/bin/${PACMAN} -D --asexp"
    alias pacimpl="sudo -E /usr/bin/${PACMAN} -D --asdep"
    alias pace="${PACMAN} -Qe"
    alias pacq="/usr/bin/${INSTALLER} -S --noconfirm"
    alias pacro='sudo -E pacman -Rs $(pacman -Qtdq)'
    alias pacla='${INSTALLER} -Qei $(pacman -Q|cut -d" " -f 1)|awk " BEGIN {FS=\":\"}/^Name/{printf(\"\033[1;36m%s\033[1;37m\", \$2)}/^Description/{print \$2}"'
fi

export WINEARCH=win32
export WINEPREFIX=~/.wine32
export EDITOR=vim

alias tarux="tar -x --xz -f"
alias tarcx="tar -c --xz -f"
alias tarug="tar xfvz"
alias tarcg="tar cfvz"

alias \#="sudo "
alias \$=""

alias dd="dd status=progress"

alias bc="bc -ql"
alias octave-cli="octave-cli -q"
alias R='R -q'

alias vi="vim"

#fetch PDB files
getpdb() {
    wget http://www.rcsb.org/pdb/files/$1.pdb 
}

export SCHRODINGER=/opt/schrodinger2015-1

#C1, C2, final V
stockdilution() {
    units --terse "($2/$1 * $3)" uL
}

eval "$RUN"

alias verynice="ionice -c3 nice -n 15"
