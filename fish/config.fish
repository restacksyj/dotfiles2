
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# eval /Users/yashjajoo/opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

# if status is-interactive
# and not set -q TMUX
#     if tmux has-session -t home
# 	exec tmux attach-session -t home
#     else
#         tmux new-session -s home
#     end
# end

set fish_greeting

function current_branch  
    set ref (git symbolic-ref HEAD 2> /dev/null); or \
    set ref (git rev-parse --short HEAD 2> /dev/null); or return
    echo $ref | sed -e 's|^refs/heads/||'
end

function parent
    git show-branch | grep '*' | grep -v "$(git rev-parse --abbrev-ref HEAD)" | head -n1 | sed 's/.*\[\(.*\)\].*/\1/' | sed 's/[\^~].*//'
end

alias cl="clear"
alias c="clear"
alias cat="bat"
alias ls="eza"
alias rm="trash"

# Git aliases

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

#set theme_color_theme tide
starship init fish | source
zoxide init fish | source
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$HOME/.cargo/bin:$PATH"
# load_nvm > /dev/stderr
# alias vi=nvim
# neofetch
# export PATH=/Users/yashjajoo/.local/share/solana/install/active_release/bin
# :/Users/yashjajoo/.local/share/solana/install/active_release/bin:/Users/yashjajoo/opt/anaconda3/bin:/Users/yashjajoo/opt/anaconda3/condabin:/Users/yashjajoo/.local/share/nvm/v12.22.12/bin:/usr/local/opt/php@7.1/sbin:/usr/local/opt/php@7.1/bin:/usr/local/opt/php@7.3/sbin:/usr/local/opt/php@7.3/bin:/usr/local/opt/php@7.2/sbin:/usr/local/opt/php@7.2/bin:/Users/yashjajoo/.fig/bin:/Users/yashjajoo/Documents/development/flutter/bin:/Users/yashjajoo/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/usr/local/share/dotnet:~/.dotnet/tools:/usr/local/go/bin:/Applications/Wireshark.app/Contents/MacOS:/Applications/kitty.app/Contents/MacOS:/Applications/Visual Studio Code.app/Contents/Resources/app/bin

fish_vi_key_bindings
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/yashjajoo/.ghcup/bin $PATH # ghcup-env
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx EDITOR nvim
