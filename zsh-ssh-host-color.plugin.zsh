# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# Fork from https://gist.github.com/773849

typeset -xA _environment_pattern
typeset -xA _color_from_environment

_environment_pattern[prod]='(^| |\.)(au1|az1|ca1|eu2|iad1|sjc1|syd1|gov1|va2|eng)($| |\.)'
_environment_pattern[stage]='(^| |\.)(g1|g1-iad)($| |\.)'
_environment_pattern[dev]='(^| |\.)(a1|a1-prv|b1|b1-prv)($| |\.)'

_color_from_environment[prod]="Homebrew"
_color_from_environment[stage]="AdventureTime"
_color_from_environment[dev]="Earthsong"

_color_from_params() {
  setopt aliases
  emulate -L zsh # so traps don't percolate up
  local oldcolor
  for environment pattern in ${(kv)_environment_pattern}; do
    if [[ "$@" =~ "$pattern" ]]; then
      oldcolor=$_iterm2colors_current
      color=$_color_from_environment[$environment]
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
