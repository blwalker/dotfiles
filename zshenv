#!/bin/zsh

[[ -f ~/.hostrc ]] && source ~/.hostrc

[[ $PATH != *"${HOME}/bin"* ]] && export PATH="${PATH}:${HOME}/bin"
