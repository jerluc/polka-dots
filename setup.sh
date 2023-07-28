#!/bin/bash

set -e

polka_dir=$(dirname $(realpath $0))

maybe_setup_link () {
    src=$1
    dst=$2
    if [ ! -h "$dst" ]; then
        ln -s $src $dst
        echo "Created symlink: $dst"
    fi
}

maybe_setup_link $polka_dir/overlays/home/.editorconfig $HOME/.editorconfig
for config_dir in $(ls $polka_dir/overlays/home/.config/); do
    maybe_setup_link $polka_dir/overlays/home/.config/$config_dir $HOME/.config/$config_dir
done
