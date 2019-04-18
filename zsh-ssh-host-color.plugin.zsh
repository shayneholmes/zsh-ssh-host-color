# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# Fork from https://gist.github.com/773849

_prod_dcs=(
  au1
  az1
  ca1
  eng
  eu2
  gov1
  iad1
  sjc1
  syd1
  va2
)

_stage_dcs=(
  g1
  g1-iad
)

_dev_dcs=(
  a1
  a1-prv
  b1
  b1-prv
)

_color_from_params() {
  # only color switch if on tty
  if [ ! -t 1 ]; then "$@"; return; fi

  typeset -xA _colorschemes
  _colorschemes[prod]="Homebrew"
  _colorschemes[stage]="AdventureTime"
  _colorschemes[dev]="Earthsong"

  _get_pattern_from_dcs() {
    _pattern=$(printf "$@" | sed "s/ /|/g")
    printf '(^| |\.)(%s)($| |\.)' "$_pattern"
  }

  typeset -xA _environment_pattern
  _environment_pattern[prod]=$(_get_pattern_from_dcs "$_prod_dcs")
  _environment_pattern[stage]=$(_get_pattern_from_dcs "$_stage_dcs")
  _environment_pattern[dev]=$(_get_pattern_from_dcs "$_dev_dcs")

  setopt aliases
  emulate -L zsh # so traps don't percolate up
  local oldcolor
  for environment pattern in ${(kv)_environment_pattern}; do
    if [[ "$@" =~ "$pattern" ]]; then
      oldcolor=$_iterm2colors_current
      color=$_colorschemes[$environment]
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
