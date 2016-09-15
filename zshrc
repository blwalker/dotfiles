#!/bin/zsh

autoload -U compinit promptinit
compinit
promptinit

setopt PROMPT_SUBST

GREEN="[32m"
BLUE="[1;34m"
LIGHT_BLUE="[38;5;39m"
NAVY="[38;5;17m"
CYAN="[36m"
ORANGE="[38;5;172m"
RED="[38;5;160m"
PEACH="[38;5;180m"
YELLOW="[33m"
RESET="[0m"

function git_current_branch()
{
	local branch
	branch=$(command git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [[ $? == 0 ]]
	then
		echo "$GREEN($branch)$RESET "
	fi
}

PROMPT='%{$LIGHT_BLUE%}%m %{$PEACH%}%1~ $(git_current_branch)%{$LIGHT_BLUE%}%#%{$RESET%} '

umask u=rwx,g=rx,o=rx
rsync ${HOME}/.ssh/good_hosts ${HOME}/.ssh/known_hosts

set -o vi

alias rm='rm -i'
