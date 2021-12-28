# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# install zplug
# # https://github.com/zplug/zplug#installation
# # を参照して zplug をインストールする
# #
# # zplug settings
source ~/.zplug/init.zsh

# zsh-nvm
export NVM_COMPLETION=true
zplug "lukechilds/zsh-nvm"
zplug "lukechilds/zsh-better-npm-completion", defer:2

# cdを強化する
# https://github.com/b4b4r07/enhancd
zplug "b4b4r07/enhancd", use:init.sh

# Vanilla shell
zplug "yous/vanilli.sh"

# 補完の強化
zplug "zsh-users/zsh-completions"

# 履歴補完の強化
zplug "zsh-users/zsh-autosuggestions"

# タスクを非同期で実行できるようにする
zplug "mafredri/zsh-async", from:github

# テーマ
# https://github.com/romkatv/powerlevel10k
# Type `p10k configure` to generate your own config for powerlevel10k.
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme, as:theme

# コマンドをハイライトしてくれる
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load # --verbose

#####################################################
################# ここから下はzshの設定 ################
#####################################################

# 入力した文字から始まるコマンドを履歴から検索し、上下矢印で補完 鍵盤コードは`bat /etc/zshrc`で確認
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# Beep音をなくす
setopt no_beep

# 履歴関連設定
setopt share_history # 他のzshと履歴を共有
setopt hist_ignore_all_dups # 同じコマンドをヒストリに保存しない
setopt hist_reduce_blanks # 無駄なスペースを消してヒストリに保存する

# 選択されたテキストの背景色を変更し、ハイライトする
zstyle ':completion:*:default' menu select=2

# パスを直接入力してもcdする
setopt AUTO_CD

# 環境変数を補完
setopt AUTO_PARAM_KEYS

# Add color to ls command
export CLICOLOR=1

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey "^R" peco_select_history

function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
          BUFFER="cd ${selected_dir}"
          zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey "^G" peco-src

# git
alias pull="git pull"
alias push="git push"
alias commit="git commit"
alias add="git add"
alias status="git status"
alias gs="git status"
alias gd="git diff"

# others
alias open="xdg-open"
alias e.="xdg-open ."
alias bat="batcat"

# ls
alias ls=lsd
alias la="lsd -a"
alias ll="lsd -al" # --blocks permission --blocks size --blocks date --blocks name"
alias tree="lsd --tree"
alias lt=tree

export LANG=ja_JP.UTF-8
export LC_ALL='ja_JP.UTF-8'

# path 設定
export PATH="$HOME/go/bin:$HOME/.local/bin:~/.cargo/bin:$PATH"

# rust
source ~/.cargo/env

# autostart docker
if [ $(service docker status | awk '{print $4}') = "not" ]; then
  sudo service docker start > /dev/null
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
