# workspace-init
Installers for my workspace tools to Linux(Debian, Ubuntu, Fedora, CentOS)

### Available tools 
go, docker, pip, awscli, cloudsdk.

### Requirements
su permission, git, curl, python

### Environments
  **v** : Go version  default: (LATEST)
  
  **p** : GOPATH      default: **/opt/go**

### Option flags
  -f : Remove the existing go installation if present prior to install

### Examples
Install the latest version of Go and export GOPATH=/opt/go
```
sudo ./install.sh go
```

Install Go 1.11.13 and export GOPATH=~/go 
```
sudo v=1.11.13 p=~/go ./install.sh go
```

Install awscli
```
sudo ./install.sh awscli
```

Install docker
```
sudo ./install.sh docker
```

## TODO
- Implement versioning to tools other than Go.
- Add support for Python3 and upgrade pip to pip3
- Handle versions of distros and make installers more specific to different versions.
