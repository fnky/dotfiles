#!/bin/zsh
source ~/.zplug/init.zsh

has_plugin() {
  (( $+functions[zplug] )) || return 1
  zplug check "${1:?too few arguments}"
  return $status
}

# zplug "b4b4r07/zplug"

# Local plugins
# zplug "~/.modules", from:local, nice:1, of:"*.sh"
# zplug "~/.zsh",     from:local, nice:2

# Remote plugins
# zplug "b4b4r07/zsh-gomi",  as:command, of:bin/gomi
# zplug "b4b4r07/http_code", as:command, of:bin
# zplug "b4b4r07/enhancd",   of:enhancd.sh
# zplug "b4b4r07/emoji-cli", if:"which jq"
# zplug "b4b4r07/zsh-vimode-visual"
# zplug "mrowa44/emojify",   as:command
# zplug "junegunn/fzf-bin",  as:command, from:gh-r, file:"fzf", frozen:1
zplug "glidenote/hub-zsh-completion"
zplug "frmendes/geometry"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

# Needs to be loaded after compinit
# zplug "zsh-users/zsh-syntax-highlighting", nice:19

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

# Source plugins and add commands to $PATH
# zplug load --verbose
zplug check || zplug install
zplug load > /dev/null
