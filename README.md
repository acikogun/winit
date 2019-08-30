# workspace-init
Installers for my workspace tools to Linux(Debian, Ubuntu, Fedora, CentOS)

### Available tools 
go, docker, pip, awscli, cloudsdk.

### Requirements
su permission, git, curl, python

### Globals
  **v**: Go version  default: **1.12.9**
  
  **p**: GOPATH      default: **/opt/go**

### Arguments
  -f: Redownload Go tar package even if it is downloaded 

### Examples
Install Go 1.12.9 and export GOPATH=/opt/go
```
sudo ./install.sh go
```

Install Go 1.11.13 and export GOPATH=~/mygoworkspace 
```
sudo v=1.11.13 p=~/mygoworkspace ./install.sh go
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

