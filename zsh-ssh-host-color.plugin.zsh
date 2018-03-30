# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# Fork from https://gist.github.com/773849

_color_from_params() {
  setopt aliases
  emulate -L zsh # so traps don't percolate up
  local oldcolor
  oldcolor=$_iterm2colors_current
  if [[ "$@" =~ '(^| |\.)(engserv-co1|au1|iad1|ca1|az1|eu2)($| |\.)' ]]; then
    _iterm2colors_apply Homebrew
  elif [[ "$@" =~ '(^| |\.)(b1|b1-prv|st3)($| |\.)' ]]; then
    _iterm2colors_apply Earthsong
  fi
  trap "_iterm2colors_apply '$oldcolor'" INT
  trap "_iterm2colors_apply '$oldcolor'" EXIT
  "$@"
  _iterm2colors_apply "$oldcolor"
}

