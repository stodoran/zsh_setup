# Overview

This file is a guide for configuring the zsh shell for a better terminal experience in a Linux environment.

# Local Installation

## Terminal

Install iterm2 from the [official website](https://iterm2.com/).

## Theme

```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
```

To configure the theme, restart your terminal and follow the instructions of the configuration wizard.
It is important to accept the installation of the MesloLGS NF font. Alternatively, a theme is als included in the repo.

# Remote Installation

```bash
bash setup.sh
```

Press enter to any prompts.

# Features

* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
* [fzf](https://github.com/junegunn/fzf)
* [powerlevel10k](https://github.com/romkatv/powerlevel10k)

For the syntax highlighter, use `fast-theme -l` to list available themes and `fast-theme {theme-name}` to set the theme.
