#!/bin/bash

function my_git_ps1()
{
	if (( $1 ))
	then
		__git_ps1
	fi
}

[[ -f ~/.hostrc ]] && . ~/.hostrc

[[ -f ~/.complrc ]] && . ~/.complrc

[[ -f ~/.stingrc ]] && . ~/.stingrc

if [[ "${CALLID}" = "" ]] && [[ -t 0 ]]
then
	stty susp '^Z'
	stty erase '^H'
	stty kill '^U'
	stty quit '^C'
fi

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

if [[ ${TERM} == xterm* ]] || [[ ${TERM} == vt100 ]]
then
	[[ -t 0 ]] && echo '^[)0'
	# to undo this do:
	# Ctrl-V ESC
	# echo '^[c'
fi

TAG=""
GREEN="\[\e[32m\]"
BLUE="\[\e[1;34m\]"
LIGHT_BLUE="\[\e[38;5;39m\]"
NAVY="\[\e[38;5;17m\]"
CYAN="\[\e[36m\]"
BLACK="\[\e[0m\]"
ORANGE="\[\e[38;5;172m\]"
RED="\[\e[38;5;160m\]"
PEACH="\[\e[38;5;180m\]"
YELLOW="\[\e[33m\]"

export PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'
export GIT_PS1_SHOWDIRTYSTATE="true"
export MYSQL_PS1="\u@\h:\d> "

if [[ ${TERM} == *256color* ]]
then
	export PS1="${LIGHT_BLUE}\h${GREEN}${TAG}${RED}\$(my_git_ps1 ${HAVE_GIT_PS1}) ${PEACH}\W${LIGHT_BLUE}>${BLACK} "
else
	export PS1="${CYAN}\h${GREEN}${TAG}${BLUE}\$(my_git_ps1 ${HAVE_GIT_PS1}) ${YELLOW}\W${CYAN}>${BLACK} "
fi

[[ "${CORESTING}" != "" ]] && export DG_ARCHIVE_DIR="${CORESTING}/$(basename ${DG_ARCHIVE_DIR})"

[[ $PATH != *"${HOME}/bin"* ]] && export PATH="${PATH}:${HOME}/bin"

umask u=rwx,g=rx,o=rx

rsync .ssh/good_hosts .ssh/known_hosts

set -o vi

alias rm='rm -i'
alias status='svn status'