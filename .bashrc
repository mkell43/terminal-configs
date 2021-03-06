# shellcheck disable=SC2148
#    __  __ _  ________ _      _      ______ _____            
#   |  \/  | |/ /  ____| |    | |    |  ____|  __ \           
#   | \  / | ' /| |__  | |    | |    | |__  | |__) |          
#   | |\/| |  < |  __| | |    | |    |  __| |  _  /           
#   | |  | | . \| |____| |____| |____| |____| | \ \           
#   |_|__|_|_|\_\______|______|______|______|_|  \_\   _      
#   |__   __|  ____|  __ \|  \/  |_   _| \ | |   /\   | |     
#      | |  | |__  | |__) | \  / | | | |  \| |  /  \  | |     
#      | |  |  __| |  _  /| |\/| | | | | . ` | / /\ \ | |     
#      | |  | |____| | \ \| |  | |_| |_| |\  |/ ____ \| |____ 
#     _|_|_ |______|_|_ \_\_|_ |_|_____|_| \_/_/    \_\______|
#    / ____/ __ \| \ | |  ____|_   _/ ____|                   
#   | |   | |  | |  \| | |__    | || |  __                    
#   | |   | |  | | . ` |  __|   | || | |_ |                   
#   | |___| |__| | |\  | |     _| || |__| |                   
#    \_____\____/|_| \_|_|    |_____\_____|                   
#                                                             
#                                                             


#=== If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#=== check the window size after each command and, if necessary,
#=== update the values of LINES and COLUMNS.
shopt -s checkwinsize

#=== UTF8 things
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#=== make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PATH="$HOME/bin:$PATH"

export DOTFILE_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
for dot in $(find $DOTFILE_DIR -maxdepth 1 -type f -name '*.dotfile'); do
    source $dot;
done

if ! [[ -x "$(command -v starship)" ]]; then
    source backup.prompt
else
    eval "$(starship init bash)"
fi;

if [[ -x "$(command -v figlet)" ]]; then
    figlet -f big "DOTFILES LOADED"
fi;

# Go straight into Tmux.
# https://unix.stackexchange.com/a/113768
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   tmux
# fi