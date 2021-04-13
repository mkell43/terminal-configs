#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "$DIR"

READLINK=$(dirname "$(readlink -f "$0")")
echo "$READLINK"