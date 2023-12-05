#!/bin/bash

set -e

polka_dir=$(dirname $(realpath $0))
machine=$(hostname)
version=$(date -u '+%s')

maybe_update () {
    home_relative_file=$1
    src="$polka_dir/overlays/home/$home_relative_file"
    dst="$HOME/$home_relative_file"

    if [[ -e "$dst" ]]; then
        read -p "Overwrite local file '$dst'? [Y/n]: " -n 1 -r
        echo    # (optional) move to a new line
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            do_update $home_relative_file
        else
            echo "Skipping update for: $dst"
        fi
    else
        do_update $home_relative_file
    fi
}

do_update () {
    home_relative_file=$1
    src="$polka_dir/overlays/home/$home_relative_file"
    dst="$HOME/$home_relative_file"

    if [[ -e "$dst" ]]; then
        cp $dst "$dst.$version.bak"
    fi
    cp $src $dst
    echo "- Updated file: $dst"

    maybe_patch $home_relative_file
}

maybe_patch () {
    home_relative_file=$1
    src="$polka_dir/patches/home/$home_relative_file"
    dst="$HOME/$home_relative_file"

    patch_file="$src.$machine.patch"
    if [[ -e "$patch_file" ]]; then
        patch -s $dst $patch_file
        echo "- Applied patch for: $dst"
    fi
}

maybe_update .editorconfig
for config_dir in $(ls $polka_dir/overlays/home/.config/); do
    for config_file in $(ls $polka_dir/overlays/home/.config/$config_dir); do
        home_relative_dir=.config/$config_dir
        home_relative_file=$home_relative_dir/$config_file

        # NOTE: For now, only overwrite files
        if [[ -f "$polka_dir/overlays/home/$home_relative_file" ]]; then
            # TODO: Add a way to force create the directory?
            if [[ ! -d "$HOME/$home_relative_dir" ]]; then
                mkdir "$HOME/$home_relative_dir"
            fi
            maybe_update $home_relative_file
        fi
    done
done
