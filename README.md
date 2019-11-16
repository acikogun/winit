# wsprov
Provisioner for tools I use on my development workstation.

- **wsprov** installs latest versions of all available tools.
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
git clone https://github.com/acikogun/wsprov.git
```

Change directory
```
cd wsprov
```

Set executable bit on
```
chmod u+x wsprov
```

Display help
```
sudo ./wsprov -h
```

### Options
  -h : Show help and exit

  -a : Install all available tools. No extra arguments required.

### Examples
Install **go**, **docker** and **cloudsdk**
```
sudo ./wsprov go docker cloudsdk
```

Install **ansible**
```
sudo ./wsprov ansible
```

Install all available tools
(awscli, azurecli, cloudsdk, docker, go, ipython, ansible, helm, terraform, packer, vagrant, eksctl)
```
sudo ./wsprov -a
```

### TODO
- Implement logging.
