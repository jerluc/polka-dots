#!/usr/bin/env bash


### <FONTS> ###

# Hack
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# SF Mono + ligatures
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized

# Sketchybar supporting fonts

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

### </FONTS> ###
