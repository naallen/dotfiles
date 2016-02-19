source fish_prompt.fish
source fish_right_prompt.fish

set fish_color_command green
set fish_color_search_match blue 
set fish_color_param normal
set fish_pager_color_completion normal -b blue

function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | .
    complete -c $alias -a "(__alias_completion_$alias)"
end

alias pac="/usr/bin/pacaur -S"
function pacu
    sudo -E pacmatic -Syu
    pacaur -Sua
    sudo -E pacmatic -Rs (pacman -Qtdq)
end
alias pacuq="/usr/bin/pacaur -Syu --noconfirm"
alias pacr="sudo -E /usr/bin/pacmatic -Rs"
alias pacrem="sudo -E /usr/bin/pacmatic -Rns"
alias pacs="/usr/bin/pacaur -Ss"
alias paci="/usr/bin/pacaur -Si"
alias pacins="sudo -E /usr/bin/pacmatic -U"
alias paclo="/usr/bin/pacmatic -Qdt"
alias pacc="sudo -E /usr/bin/pacmatic -Scc"
alias paclf="/usr/bin/pacmatic -Ql"
alias pacexpl="sudo -E /usr/bin/pacmatic -D --asexp"
alias pacimpl="sudo -E /usr/bin/pacmatic -D --asdep"
alias pace="pacmatic -Qe"
alias pacq="/usr/bin/pacaur -S --noconfirm"
alias pacro='sudo -E pacman -Rs (pacman -Qtdq)'
alias pacla='pacman -Qei (pacman -Q|cut -d" " -f 1)|awk " BEGIN {FS=\":\"}/^Name/{printf(\"\033[1;36m%s\033[1;37m\", \$2)}/^Description/{print \$2}"'

bash ~/.zsh/base16-flat.dark.sh

function conf
    switch $argv
        case conky  
          vim ~/.conkyrc ;;
        case pacman   
          sudo vim /etc/pacman.conf ;;
        case vim  
          vim ~/.vimrc ;;
        case xinit  
          vim ~/.xinitrc ;;
        case xresources 
          vim ~/.Xresources; and xrdb ~/.Xresources ;;
        case fish 
          vim ~/.config/fish/config.fish ;;
        case zsh  
          vim ~/.zshrc; and source ~/.zshrc ;;
        case i3   
          vim ~/.i3/config; and i3-msg reload;;
        case compton  
          vim ~/.compton.conf ;;
        case mutt   
          vim ~/.muttrc ;;
        case dunst   
          vim ~/.dunstrc; and killall dunst; and dunst -conf ~/.dunstrc ;;
        case *
          echo "Unknown application: $1" ;;
    end 
end
