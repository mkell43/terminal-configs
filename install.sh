#!/usr/bin/env bash

set -euo pipefail

# TODO: Run tests to make sure all the necessary apps/binaries are installed.

function configure_git() {
    git config --global core.editor "vim"
    git config --global user.name "Mike Keller"
    git config --global pull.rebase "false"
}

function check_command() {
    if ! [[ -x "$(command -v "$1")" ]]; then
        printf "Required Command '%s' Can't Be Found. Investigate Before Continuing Again.\n" "$1"
        exit 1
    fi
}

DOTFILES_DIRECTORY_NAME="dotfiles2"
DOTFILES_DIRECTORY_PATH="$HOME/$DOTFILES_DIRECTORY_NAME"

check_command "keybase"
check_command "git"
configure_git

if [[ -d "$DOTFILES_DIRECTORY_PATH" ]]; then
    printf "Dotfiles Found. Updating...\n\n"
    cd "$DOTFILES_DIRECTORY_PATH"
    git fetch
    git pull
    printf "\nDotfiles Updated.\n"
elif ! [[ -d "$DOTFILES_DIRECTORY_PATH" ]]; then
    printf "Dotfiles Not Found. Installing...\n\n"
    cd "$HOME"
    git clone keybase://private/mkell43/dotfiles $DOTFILES_DIRECTORY_NAME
    printf "\nDotfiles Installed.\n"
else
    printf "Something Went Terribly Wrong While Testing If Dotfiles Already Exist On System.\n"
fi