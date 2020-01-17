
[![CircleCI](https://circleci.com/gh/acikogun/winit.svg?style=svg)](https://circleci.com/gh/acikogun/winit)

# winit

An extensible installer for tools I use on my development workstation.

- **winit** installs latest versions of all available tools.
- Supported platforms : **linux/amd64**
- Supported distros   : Debian{9,10} Ubuntu{16,18} Centos{7,8}

## Available tools

awscli, azurecli, cloudsdk, docker, go, ipython, ansible, helm, terraform, packer, vagrant, eksctl

## Notes

- **git**, **python3** and **pip** are installed as requirements before any tool.
- **cloudsdk** automatically installs **kubectl** and enables kubectl bash completion.

## Install

 Clone repository

```bash
git clone https://github.com/acikogun/winit.git
```

Change directory

```bash
cd winit
```

Set executable bit on

```bash
chmod u+x winit
```

Display help

```bash
sudo ./winit -h
```

## Options

  -h : Show help and exit

  -a : Install all available tools. No extra arguments required.

## Examples

Install **go**, **docker** and **cloudsdk**

```bash
sudo ./winit go docker cloudsdk
```

Install **ansible**

```bash
sudo ./winit ansible
```

Install all available tools

{ awscli, azurecli, cloudsdk, docker, go, ipython, ansible, helm, terraform, packer, vagrant, eksctl, node }

```bash
sudo ./winit -a
```
