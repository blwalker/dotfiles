#!/bin/bash

function my_git_ps1()
{
	if (( $1 ))
	then
		__git_ps1
	fi
}

HAVE_GIT_PS1=0
for f in git-completion.bash git-prompt.sh
do
	COMP="/usr/share/git-core"

	if [[ -f ${COMP}/contrib/completion/$f ]]
	then
		source ${COMP}/contrib/completion/$f
		HAVE_GIT_PS1=1
	elif [[ -f /Applications/Xcode.app/Contents/Developer${COMP}/$f ]]
	then
		source /Applications/Xcode.app/Contents/Developer${COMP}/$f
		HAVE_GIT_PS1=1
	fi
done

[[ -f ~/.hostrc ]] && . ~/.hostrc

GREEN="\[\e[32m\]"
BLUE="\[\e[1;34m\]"
LIGHT_BLUE="\[\e[38;5;39m\]"
NAVY="\[\e[38;5;17m\]"
CYAN="\[\e[36m\]"
BLACK="\[\e[0m\]"
ORANGE="\[\e[38;5;172m\]"
RED="\[\e[38;5;160m\]"
BLACK="\[\e[0m\]"

export GIT_PS1_SHOWDIRTYSTATE="true"
export PS1="\[\033]0;\w\007${LIGHT_BLUE}\h${RED}\$(my_git_ps1 ${HAVE_GIT_PS1})${LIGHT_BLUE}>${BLACK} "

[[ $PATH != *"${HOME}/bin"* ]] && export PATH="${PATH}:${HOME}/bin"

set -o vi

stty erase ^H

rsync .ssh/good_hosts .ssh/known_hosts

