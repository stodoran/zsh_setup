# Overview

This file is a guide for configuring the zsh shell with iterm2 for a better terminal experience in a Linux environment.

TLDR oneliner (linux):

```
d=$(mktemp -d) && git clone https://github.com/stodoran/zsh_setup "$d/zsh_setup" && bash "$d/zsh_setup/setup.sh"
```

# Installation

## Terminal

Install iterm2 from the [official website](https://iterm2.com/).

## Theme

Manual theme installation:

```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
```

To configure the theme, restart your terminal and follow the instructions of the configuration wizard.
It is important to accept the installation of the MesloLGS NF font. Once the font is installed, it will work on any shell you connect to with iterm2.

## Setup

This needs to be run on any device that you want to use the zsh setup on. Press enter to any prompts.

```bash
git clone https://github.com/stodoran/zsh_setup
cd zsh_setup
bash setup.sh
```

# Features

## Plugins

* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
* [fzf](https://github.com/junegunn/fzf)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)

For the syntax highlighter, use `fast-theme -l` to list available themes and `fast-theme {theme-name}` to set the theme.

## Scripts

Scripts are stored in `scripts.md` and are included in the zsh history by default. Use `ctrl+R` to search for scripts. All scripts will be prefixed with `# SCRIPT:` for ease of access, and are loaded into the history on zsh startup.
