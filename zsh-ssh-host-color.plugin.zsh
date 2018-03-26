#!/bin/bash
#
# (1) copy to: ~/bin/ssh-host-color 
# (2) set:     alias ssh=~/bin/ssh-host-color
#
# Inspired from http://talkfast.org/2011/01/10/ssh-host-color
# Fork from https://gist.github.com/773849
#

function _ssh_host_color() (
  local oldcolor
  oldcolor=$_iterm2colors_current
  if [[ "$*" =~ '(^|\.)(engserv-co1|co1|iad1|ca1|az1|eu2)($|\.)' ]]; then
    _iterm2colors_apply Homebrew
  elif [[ "$*" =~ '(^|\.)(b1-prv|st3)($|\.)' ]]; then
    _iterm2colors_apply Earthsong
  fi
  trap "_iterm2colors_apply '$oldcolor'" INT
  trap "_iterm2colors_apply '$oldcolor'" EXIT
  sshrc "$@"
  _iterm2colors_apply "$oldcolor"
)

function _ssh_host_color_complete() {
  local service=ssh
  _ssh "$@"
}

compdef _ssh_host_color_complete _ssh_host_color

alias ssh=_ssh_host_color
