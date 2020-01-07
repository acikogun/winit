# winit
Provisioner for tools I use on my development workstation.

- **winit** installs latest versions of all available tools.
- Supported platforms : **linux/amd64**
- Supported distros   : Debian{9,10} Ubuntu{16,18} Centos{7,}

### Available tools
awscli, azurecli, cloudsdk, docker, go, ipython, ansible, helm, terraform, packer, vagrant, eksctl

### Notes
- **git**, **python3** and **pip** are installed indirectly before any tool.
- **cloudsdk** automatically installs **kubectl** and enables kubectl bash completion.
- **azurecli** automatically installs **az devops** extension.

### Install
 Clone repository
```
git clone https://github.com/acikogun/winit.git
```

Change directory
```
cd winit
```

Set executable bit on
```
chmod u+x winit
```

Display help
```
sudo ./winit -h
```

### Options
  -h : Show help and exit

  -a : Install all available tools. No extra arguments required.

### Examples
Install **go**, **docker** and **cloudsdk**
```
sudo ./winit go docker cloudsdk
```

Install **ansible**
```
sudo ./winit ansible
```

Install all available tools
(awscli, azurecli, cloudsdk, docker, go, ipython, ansible, helm, terraform, packer, vagrant, eksctl)
```
sudo ./winit -a
```

### TODO
- Implement logging.
