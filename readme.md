# Dotfiles

Notes about the various dot files

## Boot strap your Linux environment

Unfortunately there is a chicken and egg scenario, where we need the enterprise cert, but to
get it we need the cert for the https connection. Same goes for git-credentials, so you'll need 
to do a once off git clone command using basic auth

Currently only Fedora is supported

```
mkdir ~/.config/
GITLAB_TOKEN=<insert token>
GIT_SSL_NO_VERIFY=1 git clone https://__token__:${GITLAB_TOKEN}@gitlab.com/bhp-cloudfactory/pscdp/common/wsl-corporate-dots.git
sudo ln -s $HOME/.config/dotfiles/tuckr /usr/local/bin/tuckr
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


### Install uv and common tools

Installing uv will also install the following common utilties which are best managed via uv

`tuckr set uv`

* pre-commit
* ruff
* poetry
* just - a generic command runner inspired by make


