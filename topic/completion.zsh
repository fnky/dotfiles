# npm completions
eval "`npm completion`"

# completion for lunchy
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
  . $LUNCHY_DIR/lunchy-completion.zsh
fi

# completion for swiftenv
if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi
