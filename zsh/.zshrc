# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load zgen  -*- mode: sh; -*-

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# These lines needs to be before loading oh-my-zsh
source "${HOME}/.zgen/zgen.zsh"

# check if there's no init script

HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE

if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/tig
    zgen oh-my-zsh plugins/systemd
    zgen oh-my-zsh plugins/fzf
    zgen oh-my-zsh plugins/gpg-agent
    zgen oh-my-zsh plugins/npm
    # zgen oh-my-zsh plugins/npx
    zgen oh-my-zsh plugins/pass
    zgen oh-my-zsh plugins/archlinux
    zgen oh-my-zsh plugins/vi-mode
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/golang
    zgen oh-my-zsh plugins/gradle
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/fasd
    zgen oh-my-zsh plugins/nmap
    zgen oh-my-zsh plugins/last-working-dir
    zgen oh-my-zsh plugins/themes
    zgen oh-my-zsh plugins/mosh
    zgen oh-my-zsh plugins/cp
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/python
	zgen oh-my-zsh plugins/ssh-agent
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zaw
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-autosuggestions
    zgen load changyuheng/zsh-interactive-cd
    zgen load marzocchi/zsh-notify
    zgen load joel-porquet/zsh-dircolors-solarized
    zgen load djui/alias-tips
    zgen load Tarrasch/zsh-bd
    zgen load larkery/zsh-histdb
    zgen load romkatv/powerlevel10k powerlevel10k
    # zgen load lukechilds/zsh-nvm

    # theme
    # zgen oh-my-zsh themes/agnoster

    # save all to init script
    zgen save
fi

export FZF_BASE="/usr/bin/fzf"

zstyle :omz:plugins:ssh-agent identities work personal

_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

tmb() {
    local WHERE=$TOMBS/$1
    tomb open "$TOMBS/$1.tomb" $WHERE -k "$TOMBS/$1.tomb.key" -g
}

ZSH_AUTOSUGGEST_STRATEGY=histdb_top_here

# Zaw
zstyle ':filter-select' max-lines 6 # use $LINES - 4 for filter-select
zstyle ':filter-select' case-insensitive yes # enable case-insensitive search

bindkey '^R' zaw-history
bindkey -M filterselect '^[j' down-line-or-history
bindkey -M filterselect '^[k' up-line-or-history
bindkey -M filterselect '^E' accept-search
bindkey '^P' zaw-process
bindkey '^F' zaw-open-file
bindkey '^[^M' autosuggest-execute
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
# This is a fix for home and end buttons
# https://github.com/ohmyzsh/ohmyzsh/issues/7330#issuecomment-475844784
typeset -A key
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

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
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Keypad
# 0 . Enter
# https://github.com/ohmyzsh/ohmyzsh/issues/3061#issuecomment-136554709
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

export JAVA_HOME=/usr/lib/jvm/default
export DEFAULT_USER="sharp"
export GOPATH="$HOME/.go"
export ANDROID_HOME="/home/sharp/Android/Sdk"
export EDITOR=nvr
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"
export PYENV_ROOT="$HOME/.pyenv"
export LEDGER_FILE="$HOME/Documents/accounting/ledger.ledger"
export LEDGER_PRICE_DB="$HOME/Documents/accounting/price-db.ledger"
export TOMBS="$HOME/tombs"
export PASSWORD_STORE_TOMB_FILE="$TOMBS/pass.tomb" # for pass-tomb
export PASSWORD_STORE_TOMB_KEY="$TOMBS/pass.tomb.key" # for pass-tomb
export BORG_CONFIG_DIR="/home/sharp/borg"
export BORG_CACHE_DIR="/home/sharp/borg/cache"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500' "
alias e=$EDITOR
alias vim=nvim
alias n=nvim
alias down="aria2c --conf-path=${HOME}/.aria2/down.conf"
alias bdown="aria2c --conf-path=${HOME}/.aria2/bersam.conf"
alias tdown="aria2c --all-proxy=http://127.0.0.1:7777 --conf-path=${HOME}/.aria2/down.conf"
alias rdown="aria2c --enable-rpc --rpc-listen-port=6800 --rpc-listen-all=true --conf-path=${HOME}/.aria2/down.conf"
alias o='xdg-open'
alias xclip='xclip -selection clipboard'
alias j='fasd_cd -d'
alias jj='fasd_cd -d -i'
alias tags="grep -orh '@.*' ~/Notes/journal | sort | uniq -c"
alias ledger="ledger --pedantic --explicit --strict"
alias ledger-bal="ledger balance ^assets -X Kirt"
alias whc="tig HEAD..origin/master"
alias fs="flow status"
alias es="eslint"
alias tr="systemctl restart tor"
alias lg="journalctl -exfu"
alias dl="aria2c -x16"
alias dlm="aria2c --dir=./ --input-file=urls.txt --max-concurrent-downloads=1 --connect-timeout=60 --max-connection-per-server=16 --split=16 --min-split-size=1M --human-readable=true --download-result=full --file-allocation=none"
alias gblu="git remote update origin --prune"
alias nr="npm run"
alias ns="npm start"
alias ni="npm install"
alias nl="npm run lint"
alias nt="npm run test"
alias nb="npm run build"
alias nd="npm run dev"
alias nta="npm run test:all"
alias nrd="npm run dev"
alias nmr="sudo systemctl restart NetworkManager"
alias gf="git fetch --all --prune"
alias gmd="gm origin/develop"
alias gpsu="gp --set-upstream origin"
alias pr="pulseaudio -k ; pulseaudio -D"
alias pi="ssh pi@192.168.0.104"
alias kv="kill -9 $(ps aux --sort -rss  | awk '/vlc/ {print $2}' | head -n1)"
alias kd="kill -9 $(ps aux --sort -rss  | awk '/dota/ {print $2}' | head -n1)"
alias sm="/home/sharp/Software/macOS-Simple-KVM/basic.sh"
alias pass-gen="node $PWD/passwordGenerator.js"

# vpn aliases
alias p="protonvpn"
alias pc="protonvpn c us-free#3"
alias ex="expressvpn"
alias ec="expressvpn connect smart"
alias ecg="expressvpn connect defr1"
alias ed="expressvpn disconnect"
alias ecu="expressvpn connect usny"
alias nc="nordvpn connect"
alias ncg="nordvpn connect germany"
alias nd="nordvpn disconnect"
alias configure-appleid="echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode"

export PATH=$PATH:$HOME/.cabal/bin
export PATH=$HOME/.bin:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools
export PATH=$PATH:$JAVA_HOME/bin
export PATH=$PYENV_ROOT/bin:$PATH
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
NPM_PACKAGES="${HOME}/.npm-global"
export PATH="$PATH:$NPM_PACKAGES/bin"

export PATH="$PATH:$HOME/.config/rofi/bin"


eval "$(direnv hook zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
