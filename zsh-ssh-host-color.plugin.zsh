# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# Fork from https://gist.github.com/773849


function _ssh_host_color() (
  local oldcolor
  oldcolor=$_iterm2colors_current
  if [[ "$*" =~ '(^| |\.)(engserv-co1|co1|iad1|ca1|az1|eu2)($| |\.)' ]]; then
    _iterm2colors_apply Homebrew
  elif [[ "$*" =~ '(^| |\.)(b1|b1-prv|st3)($| |\.)' ]]; then
    _iterm2colors_apply Earthsong
  fi
  trap "_iterm2colors_apply '$oldcolor'" INT
  trap "_iterm2colors_apply '$oldcolor'" EXIT
  $@
  _iterm2colors_apply "$oldcolor"
)

function _ssh_color() {
  _ssh_host_color ssh $@
}

function _sshrc_color() {
  _ssh_host_color sshrc $@
}

function _ssh_complete() {
  local service=ssh
  _ssh "$@"
}

compdef _ssh_complete _ssh_color
compdef _ssh_complete _sshrc_color

alias ssh="_ssh_color"
alias sshrc="_sshrc_color"
