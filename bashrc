#!/bin/bash

function my_git_ps1()
{
	if (( $1 ))
	then
		__git_ps1
	fi
}

export TAG=""

[[ -f ~/.hostrc ]] && . ~/.hostrc

[[ -f ~/.complrc ]] && . ~/.complrc

[[ -f ~/.stingrc ]] && . ~/.stingrc

HAVE_GIT_PS1=0
for f in git-completion.bash git-prompt.sh
do
	for d in "/usr/local/share/git-core/contrib/completion" "/usr/local/etc/bash_completion.d" "/usr/share/git-core/contrib/completion" "/Applications/Xcode.app/Contents/Developer/usr/share/git-core"
	do
		if [[ -f "${d}/${f}" ]]
		then
			source "${d}/${f}"
			HAVE_GIT_PS1=1
		fi
	done
done

if [[ ${TERM} == xterm* ]] || [[ ${TERM} == vt100 ]]
then
	[[ -t 0 ]] && echo 'm'
	# to undo this do:
	# Ctrl-V ESC
	# echo '^[c'
fi

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

[[ $PATH != *"${HOME}/bin"* ]] && export PATH="${PATH}:${HOME}/bin"

umask u=rwx,g=rx,o=rx
rsync ${HOME}/.ssh/good_hosts ${HOME}/.ssh/known_hosts

set -o vi

alias status='svn status'
alias up='svn update -r HEAD'
alias sd='svn diff | cdiff'

alias rm='rm -i'

