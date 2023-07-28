#!/bin/bash

set -xe

polka_dir=$(dirname $(realpath $0))
configs=$(ls $polka_dir/overlays/home/.config/)

for config_dir in $configs; do
    ln -s $polka_dir/overlays/home/.config/$config_dir $HOME/.config/$config_dir
done
