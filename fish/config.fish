set fish_greeting
# set -gx VOLTA_HOME "$HOME/.volta"
# set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx EDITOR nvim

starship init fish | source
zoxide init fish | source

fish_vi_key_bindings
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/yashjajoo/.ghcup/bin $PATH # ghcup-env

# Very useful code
# function cenv
#     if count $argv > /dev/null
#         # vi -c "normal 128jztf.lct.$argv" ~/Documents/freightbro/fb-shipper/vendor/laravel/framework/src/Illuminate/Foundation/Application.php  -c 'wq'
#         vi -es +"normal 128jztf.lct.$argv" ~/Documents/freightbro/fb-shipper/vendor/laravel/framework/src/Illuminate/Foundation/Application.php  -c 'wq'
#         # ex +"norm 128jztf.lct.$argv" +"wq" ~/Documents/freightbro/fb-shipper/vendor/laravel/framework/src/Illuminate/Foundation/Application.php 
#     end
# end

alias cl="clear"
alias c="clear"
alias cat="bat"
alias ls="eza"
alias rm="trash"
alias gc="git commit"
alias gcm="git commit -m"
alias gs="git status"
alias ga="git add"
alias gfa="git fetch --all"
alias gsw="git switch"
alias gswp="git switch -"
alias gpl="git pull origin (current_branch)"
alias gpu="git push origin (current_branch)"
# alias parent_branch="(parent)"
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim "
alias f="z"
alias dy="dig +noall +answer +additional $argv @dns.toys"
alias fl="redis-cli FLUSHDB"
alias goo="go mod tidy && go mod vendor"
alias pdf="tdf"


function appid
    if test (count $argv) -gt 0
        osascript -e "id of app \"$argv[1]\""
    else
        echo "Please pass the application name as an argument."
    end
end


function vi
    if count $argv > /dev/null
        nvim $argv
    else
        nvim .
    end
end

function mdf
    if count $argv > /dev/null
        g++ -Wall -std=c++20 $argv &&  ./a.out
    end
end

function gog
    if count $argv > /dev/null
        # set cwd (echo (pwd))
        # cd $cwd
        cd ~/Documents/freightbro/f5-go-core-utils/
        set output (go get gitlab.freightify.in/generic/f5-models-go@$argv);
        echo $output
        go mod tidy && go mod vendor
        cd ~/Documents/freightbro/f5-models-go/
    end
end

function copyfile
    if test -f "$argv"
        set file_path (realpath $argv)
        osascript -e "set the clipboard to POSIX file \"$file_path\""
        echo "File copied to clipboard: $file_path"
    else
        echo "File not found: $argv"
    end
end

function current_branch  
    set ref (git symbolic-ref HEAD 2> /dev/null); or \
    set ref (git rev-parse --short HEAD 2> /dev/null); or return
    echo $ref | sed -e 's|^refs/heads/||'
end

function parent
    git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
end


# Created by `pipx` on 2024-07-13 12:55:23
# set PATH $PATH /Users/restacksyj/.local/bin

# bun
#set --export BUN_INSTALL "$HOME/.bun"
#set --export PATH $BUN_INSTALL/bin $PATH

#source ~/.asdf/asdf.fish
#source ~/.asdf/plugins/golang/set-env.fish
