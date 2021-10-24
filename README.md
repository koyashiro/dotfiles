# dotfiles

[![Lint](https://github.com/koyashiro/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/lint.yml)
[![actionlint](https://github.com/koyashiro/dotfiles/actions/workflows/actionlint.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/actionlint.yml)

[![Arch Linux](https://github.com/koyashiro/dotfiles/actions/workflows/archlinux.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/archlinux.yml)
[![Debian](https://github.com/koyashiro/dotfiles/actions/workflows/debian.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/debian.yml)
[![Ubuntu](https://github.com/koyashiro/dotfiles/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/ubuntu.yml)
[![Alpine Linux](https://github.com/koyashiro/dotfiles/actions/workflows/alpine.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/alpine.yml)
[![macOS](https://github.com/koyashiro/dotfiles/actions/workflows/macos.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/macos.yml)
[![Windows](https://github.com/koyashiro/dotfiles/actions/workflows/windows.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/windows.yml)

## Installation

### Linux / macOS

```sh
git clone git@github.com:koyashiro/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Windows

```ps1
Set-ExecutionPolicy RemoteSigned
git clone git@github.com:koyashiro/dotfiles.git ~\.dotfiles
cd ~\.dotfiles
.\install.ps1
```

## Lint

```sh
act --job lint
```

## Test

### on Alpine Linux

```sh
act --job test-on-alpine
```

### on Arch Linux

```sh
act --job test-on-archlinux
```

### on Debian

```sh
act --job test-on-debian
```

### on Ubuntu

```sh
act --job test-on-ubuntu
```
