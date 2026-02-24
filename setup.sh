#!/usr/bin/env bash
# Script Name: setup_zsh.sh
# Author: Stefan Todoran
# Date: October 2, 2025
# Version: 1.0
# Description: 
#   This script sets up zsh as the default shell and installs oh-my-zsh
#   (a zsh plugin manager), zsh-autosuggestions, zsh-syntax-highlighting, 
#   and powerlevel10k (custom theme). Run as root or with sudo. Note that
#   the powerlevel10k theme requires that MesloLGS NF font be installed.
#   This can be automatically done by running `p10k configure` if using
#   iTerm2, otherwise it needs to be manually installed as detailed here:
#   https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

set -euo pipefail

# Backup old .zshrc file if it exists
if [ -f "$HOME/.zshrc" ]; then
  echo "-> Backing up existing .zshrc file"
  cp -a "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%F_%H%M%S)"
else
  echo "-> No existing .zshrc found; skipping backup"
fi

# Install zsh and set it as the default shell
echo "-> Installing zsh"
sudo apt update || true
sudo apt install -y zsh

username="$(id -un)"
echo "-> Setting $username's default shell to zsh"
ZSH_PATH="$(command -v zsh || true)"
sudo chsh -s "${ZSH_PATH:-/bin/zsh}" "$username"

echo "-> Uninstalling old oh-my-zsh (if any), reinstalling latest"
rm -rf "$HOME/.oh-my-zsh"
RUNZSH=no OVERWRITE_CONFIRMATION=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""

# Add env variables from .bashrc to .zshrc
echo "-> Copying env variables from .bashrc"
{
  echo ""
  echo "# === Imported from .bashrc on $(date) ==="
  grep -E '^\s*(export[[:space:]]+)?[A-Za-z_][A-Za-z0-9_]*=' "$HOME/.bashrc"
  echo "# === Imported from .bashrc on $(date) ==="
} >> "$HOME/.zshrc"

echo "-> Installing zsh-autosuggestions"
rm -rf ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "# zsh-autosuggestions" >> ~/.zshrc
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo "export ZSH_AUTOSUGGEST_STRATEGY=(history completion match_prev_cmd)" >> ~/.zshrc

echo "-> Uninstalling old fzf version (if any), installing latest fzf"
sudo apt remove fzf || true
rm -rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --completion --key-bindings --update-rc

echo "-> Installing powerlevel10k"
rm -rf ~/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> ~/.zshrc

echo "-> Copying custom powerlevel10k theme"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cp "$SCRIPT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

echo "-> Configuring powerlevel10k instant prompt"
cat >> "$HOME/.zshrc" <<'ZSH_INSTANT_PROMPT'
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
printf '\n%.0s' {1..100}
ZSH_INSTANT_PROMPT

echo "-> Installing fast-syntax-highlighting"
rm -rf ~/.zsh/fast-syntax-highlighting
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
echo "source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" >> ~/.zshrc

# Start a new shell to apply the changes
echo "-> Starting zsh"
exec zsh
