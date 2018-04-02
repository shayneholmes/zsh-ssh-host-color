# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# Fork from https://gist.github.com/773849

typeset -xA _color_from_params_patterns

_color_from_params_patterns+=("Homebrew" '(^| |\.)(engserv-co1|au1|iad1|ca1|az1|eu2)($| |\.)')
_color_from_params_patterns+=("Earthsong" '(^| |\.)(b1|b1-prv|st3)($| |\.)')

_color_from_params() {
  setopt aliases
  emulate -L zsh # so traps don't percolate up
  local oldcolor
  for color pattern in ${(kv)_color_from_params_patterns}; do
    if [[ "$@" =~ "$pattern" ]]; then
      oldcolor=$_iterm2colors_current
      _iterm2colors_apply "$color"
      trap "_iterm2colors_apply '$oldcolor'" INT
      trap "_iterm2colors_apply '$oldcolor'" EXIT
      break
    fi
  done
  "$@"
  if [ "$oldcolor" ]; then
    _iterm2colors_apply "$oldcolor"
  fi
}

