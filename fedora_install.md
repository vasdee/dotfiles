# Fedora Install Notes

## Enable flathub for flatpaks

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

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


## AppImage launcher

https://github.com/TheAssassin/AppImageLauncher/wiki/Install-on-Fedora

place appimages into ~/.local/applications/

## Install display-link drivers for docks

Allows using docks that implement the display-link protocol for USB-C, monitors, charging and networking

https://github.com/displaylink-rpm/displaylink-rpm


```
sudo dnf install ~/Downloads/fedora-34-displaylink-1.9.1-1.x86_64.rpm
```

## Disable SELinux and firewalld

```
sudo setenforce 0
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


## Install docker


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


## Install Microsoft Powershell

From https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-7.1#fedora

```
# Register the Microsoft signature key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Register the Microsoft RedHat repository
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

# Update the list of products
sudo dnf check-update

# Install a system component
sudo dnf install compat-openssl10

# Install PowerShell
sudo dnf install -y powershell

# Start PowerShell
pwsh
```

## Install starship.rs

Starship exists within the RPM fusion repositories

```
sudo dnf install starship
```

## Install Google Chrome

Download RPM directly from google

https://www.google.com/chrome/



## Random software to install

tmux
emacs
stow
gnome-tweaks
tlp
the_silver_searcher
dotnet-sdk-3.1
dotnet-sdk-5.0
powertop
