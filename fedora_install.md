# Fedora Install Notes

## Enable fast mirror support for DNF

add `fastestmirror=1` to `/etc/dnf/dnf.conf`

## install tray icons support

```
sudo dnf install libappindicator-gtk3 libappindicator
```

then install extension

https://extensions.gnome.org/extension/615/appindicator-support/

## insync client

https://www.insynchq.com/downloads


## disable selinux 

```
sudo setenforce 0
```


## disable firewalld

```
sudo systemctl disable firewalld.service 
sudo systemctl stop firewalld.service
```


## Enable RPM Fusion

https://docs.fedoraproject.org/en-US/quick-docs/setup_rpmfusion/

```
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```

### Other packages

https://pkgs.org/


## Intall docker


```
sudo usermod -a -G docker vasdee
```

https://docs.docker.com/engine/install/fedora/

```
sudo dnf remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine


sudo dnf -y install dnf-plugins-core

sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo


sudo dnf install docker-ce docker-ce-cli containerd.io
```


## Install Azure CLI

https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=dnf


```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc


echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo


sudo dnf install azure-cli
```


## Install starship.rs

```
sudo dnf install starship

```

## Random software to install

tmux
emacs
chrome
stow
gnome-tweaks
tlp
