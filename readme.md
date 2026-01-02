# Dotfiles

Dotfiles and general purpose installers for various flavours of linux (and macos). 

Uses tuckr under the hood to provide the symlinking and pre/post/hook running

Currently Fedora/RHEL, Debian/Ubuntu and SteamOS are supported

# Install

Yolo it onto your system via a single command

``` bash
curl -sL https://github.com/vasdee/dotfiles/install.sh | bash
```

Or run the guts of the install manually

```bash

read -p "Enter your default code base directory. [default: ~/code]" DEFAULT_CODE_DIR
DEFAULT_CODE_DIR=${DEFAULT_CODE_DIR:-~/code}
CLONE_DIR=$DEFAULT_CODE_DIR/github.com/vasdee/dotfiles 
mkdir -p $CLONE_DIR
git clone https://github.com/vasdee/dotfiles.git $CLONEDIR
cd $CLONEDIR
ln -s $PWD/bin/$(uname -s)/tuckr $HOME/.local/bin/tuckr

```

# Passwords

I like using a `~/.netrc` file as my single source of truth for credential management. Others might not, but either
way I like to keep the contents of that file within a dedicated password manager, rather than keep it within these dots,
which is an option


# Updating local tuckr as new version emerge

```
sudo dnf install cargo
cargo install tuckr
mv ~/.cargo/bin/tuckr ~/.config/dotfiles/tuckr
TUCKR_VERSION=$(tuckr --version)
git commit -m "updated ${TUCKR_VERSION// /-}"
```

# First Steps 

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

### Emacs

Run these after m-x

all-the-icons-install 
nerd-icons-install
