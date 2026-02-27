#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$DOTFILES/$1"
    local dst="$HOME/$1"
    mkdir -p "$(dirname "$dst")"
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "Backing up existing $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ln -sf "$src" "$dst"
    echo "Linked $dst -> $src"
}

link .config/nvim
link .config/ghostty
link .tmux.conf
link .claude/CLAUDE.md
link .claude/settings.json
