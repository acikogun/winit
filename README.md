[![CircleCI](https://circleci.com/gh/acikogun/winit.svg?style=svg)](https://circleci.com/gh/acikogun/winit)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/51da81193a1848cab9962136cad93fc8)](https://app.codacy.com/manual/acikogun/winit?utm_source=github.com&utm_medium=referral&utm_content=acikogun/winit&utm_campaign=Badge_Grade_Dashboard)
[![CodeFactor](https://www.codefactor.io/repository/github/acikogun/winit/badge)](https://www.codefactor.io/repository/github/acikogun/winit)

# winit

An extensible installer for tools I use on my development workstation.

-  **winit** installs latest versions of all available tools.
-  Supported platforms : **linux/amd64**
-  Supported distros   : Debian{9,10} Ubuntu{16,18} Centos{7,8}

## Available tools

- ansible
- awscli
- azurecli
- cloudsdk
- docker
- eksctl
- go
- helm
- ipython
- java8
- java11
- node
- packer
- shellcheck
- terraform
- vagrant


## Notes

-  **git**, **python3** and **pip** are installed as requirements before any tool.
-  **node** version is LTS(Erbium). **npm** and **yarn** is installed as dependency.
-  **cloudsdk** installs **kubectl** as dependency.
-  **docker** installs **docker-compose** as dependency.
-  bash completion is enabled for **aws**, **gcloud**, **kubectl**, **helm**, **eksctl**, **az**,
   and **npm**.

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

  -l - List all available tools

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

```bash
sudo ./winit -a
```
### Note

When you run **./winit -a** you can still ignore tools in **tools.txt** file by commenting them out.

For example; the **tools.txt** content below won't install **awscli**, **azurecli** and **java11**.

```plain
#ansible
#awscli
azurecli
cloudsdk
docker
eksctl
go
helm
ipython
java8
#java11
node
packer
shellcheck
terraform
vagrant
```
