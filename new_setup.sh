#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

ln -s $SCRIPTPATH/.vimrc $HOME/.vimrc
ln -s $SCRIPTPATH/.vim $HOME/.vim
