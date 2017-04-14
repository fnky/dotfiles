# set editor
export VISUAL=subl
export EDITOR=$VISUAL
export GIT_EDITOR="subl -n -w"

# Use UTF-8 encoding for everything
export LANG=en_US.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# syntax highlight
# ZSH_HIGHLIGHT_DIR=/usr/local/share/zsh-syntax-highlighting
# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=$ZSH_HIGHLIGHT_DIR/highlighters
# source $ZSH_HIGHLIGHT_DIR/zsh-syntax-highlighting.zsh

# Global
export LANG=en_US.UTF-8
[ "$PLATFORM" = 'Darwin' ] ||
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:.:/usr/local/lib

# OS X - prevent ._* files in tar ballz
export COPYFILE_DISABLE=true

# Git

# gitdiffb - show diff between two branches
gitdiffb() {
  if [ $# -ne 2 ]; then
    echo two branch names required
    return
  fi
  git log --graph \
    --pretty=format: '%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' \
    --abbrev-commit --date=relative $1..$2
}

alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

# fd - cd to selected directory
fd() {
  DIR=`find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf-tmux` \
    && cd "$DIR"
}

# fda - including hidden directories
fda() {
  DIR=`find ${1:-.} -type d 2> /dev/null | fzf-tmux` && cd "$DIR"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# c - browse chrome history
chs() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
  ruby -ne '
    cols = ENV["cols"].to_i
    title, url = $_.split(ENV["sep"])
    len = 0
    puts "\x1b[36m" + title.each_char.take_while { |e|
      if len < cols
        len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
      end
    }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
  fzf --ansi --multi --no-hscroll --tiebreak=index |
  sed 's#.*\(https*://\)#\1#' | xargs open
}
