# dotfiles

[![CI](https://github.com/koyashiro/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/koyashiro/dotfiles/actions/workflows/ci.yml)

## Installation

### Linux

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
