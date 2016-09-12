# Simple calculator
function calc {
  local result="";
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')";
  #                       └─ default (when `--mathlib` is used) is 20
  #
  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
        -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//';  # remove trailing zeros
  else
    printf "$result";
  fi;
  printf "\n";
}

# Create a new directory and enter it
function mkd {
  mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* *;
  fi;
}

function hlight {
  if [ -z "$2" ]
    then src="pbpaste"
  else
    src="cat $2"
  fi
  $src | highlight -O rtf --syntax $1 --font "Roboto Mono" --style zenburn --font-size 20 | pbcopy
}

# Create a data URL from a file
function dataurl {
  local mimeType=$(file -b --mime-type "$1");
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8";
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')";
}

# Create a git.io short URL
function gitio {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`";
    return 1;
  fi;
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}";
}

# Start an HTTP server from a directory, optionally specifying the port
function server {
  local port="${1:-8000}";
  sleep 1 && open "http://localhost:${port}/" &
  # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
  # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
  python -c $'import http.server;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver {
  local port="${1:-4000}";
  local ip=$(ipconfig getifaddr en1);
  sleep 1 && open "http://${ip}:${port}/" &
  php -S "${ip}:${port}";
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript;
  else # pipe
    python -mjson.tool | pygmentize -l javascript;
  fi;
}

# Run `dig` and display the most useful info
function digga {
  dig +nocmd "$1" any +multiline +noall +answer;
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
function s {
  if [ $# -eq 0 ]; then
    subl .;
  else
    subl "$@";
  fi;
}

# `a` with no arguments opens the current directory in Atom Editor, otherwise
# opens the given location
function a {
  if [ $# -eq 0 ]; then
    atom .;
  else
    atom "$@";
  fi;
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
function v {
  if [ $# -eq 0 ]; then
    vim .;
  else
    vim "$@";
  fi;
}

nv () {
	if [ $# -eq 0 ]
	then
		nvim .
	else
		nvim "$@"
	fi
}

vs () {
  VSCODE_CWD="$PWD"

  if [ $# -eq 0 ]
  then
    cwd=.
  else
    cwd="$@"
  fi

  open -n -b "com.microsoft.VSCode" --args $cwd ;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o {
  if [ $# -eq 0 ]; then
    open .;
  else
    open "$@";
  fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# Attach or create a tmux session.
#
# You can provide a name as the first argument, otherwise it defaults to the current directory name.
# The argument tab completes among existing tmux session names.
#
# Example usage:
#
#   tat some-project
#
#   tat s<tab>
#
#   cd some-project
#   tat
#
# Based on https://github.com/thoughtbot/dotfiles/blob/master/bin/tat
# and http://krauspe.eu/r/tmux/comments/25mnr7/how_to_switch_sessions_faster_preferably_with/
#
function tat {
  session_name=`basename ${1:-$PWD}`
  tmux new-session -As "$session_name"
}

# function _tmux_complete_session {
#   local IFS=$'\n'
#   local cur=${COMP_WORDS[COMP_CWORD]}
#   COMPREPLY=( ${COMPREPLY[@]:-} $(compgen -W "$(tmux -q list-sessions | cut -f 1 -d ':')" -- "${cur}") )
# }

# complete -F _tmux_complete_session tat
