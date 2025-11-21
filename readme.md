# Dotfiles

Notes about the various dot files

## Boot strap your WSL Linux environment

Unfortunately there is a chicken and egg scenario, where we need the enterprise cert, but to
get it we need the cert for the https connection. Same goes for git-credentials, so you'll need 
to do a once off git clone command using basic auth

Currently Fedora/RHEL and Debian/Ubuntu are supported

```
GITLAB_TOKEN=<insert token>
mkdir ~/.config/
GIT_SSL_NO_VERIFY=1 git clone https://__token__:${GITLAB_TOKEN}@gitlab.com/bhp-cloudfactory/pscdp/common/wsl-corporate-dots.git
sudo ln -s $HOME/.config/dotfiles/tuckr /usr/local/bin/tuckr
tuckr -p ~/.config/wsl-corporate-dots set root
```


## Updating local tuckr as new version emerge

```
sudo dnf install cargo
cargo install tuckr
mv ~/.cargo/bin/tuckr ~/.config/dotfiles/tuckr
TUCKR_VERSION=$(tuckr --version)
git commit -m "updated ${TUCKR_VERSION// /-}"
```

## First Steps 

### install root config for enterprise cert

`TUCKR_HOME=$HOME/.config sudo -E tuckr set root`


### Next steps

Install whatever is required for your WSL install. By default, each group is self managed so running

`tuckr set docker` for instance will install docker as pre-hook step, then provide any configuration within your home dir




### Install uv and common tools

Installing uv will also install the following common utilties which are best managed via uv

`tuckr set uv`

* pre-commit
* ruff
* poetry
* just - a generic command runner inspired by make


