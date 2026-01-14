# Dotfiles

![SHOW ME WHAT YOU DOT!](img/what-you-dot-50.jpg)

Dotfiles and general purpose installers for various flavours of linux (and macos).

Uses [tuckr](https://github.com/RaphGL/Tuckr) under the hood to provide the symlinking and pre/post/hook running

Currently Fedora/RHEL, Debian/Ubuntu and SteamOS are supported

It has cross platform support, so volunteers who want to add OSX support are welcome to contribute to that side of
things.

## Why would you use this?

* Because you can't remember where that work proxy certificate needs to be before you call that update-ca command you
  can't remember either...
* Because you can't remember how to officially install docker within your chosen distro, then change it for container
  builds...
* Because you aren't sure if you should install pre-commit manually via your package manager or some other way...
* Because you want to consistently install software locally and in pipelines or docker builds...
* Because you gaslit yourself with the average notes you left yourself last time you did this...

## Install

Yolo it onto your system via a single command

``` bash
curl -sL https://raw.githubusercontent.com/vasdee/dotfiles/install.sh | sh
```

Or run the guts of the install manually

```bash
CLONE_URL=https://github.com/vasdee/dotfiles.git
CLONE_DIR=~/.config/dotfiles
mkdir -p $CLONE_DIR
git clone $CLONE_URL $CLONE_DIR
cd $CLONE_DIR
ln -s $PWD/bin/$(uname -s)/$(uname -m)/tuckr ~/.local/bin/tuckr
```

## Some opinionated notes

## ~/.localsettings

There is nothing stopping you from using multiple `tuckr` profiles and running things like
`tuckr -p mydots my-emacs-config` alongside this dotfiles repo. However, for those small configuration choices where
another fullblown dotfile repo isn't required, then you can use the `~/.localsettings` to provide whatever variable
customisations you require.

Currently it holds the `DEFAULT_CODE_DIR` and `git` usernames and emails for work/private configurations.

## Shell directories

Where possible, `config.d` practices are adopted for including separate config files. This is generally a good practice
everywhere, as it allows your most "top-most" config file, say `~/.bashrc`, `~/.zshrc` or `~/.ssh/config` to not be
manipulated by this library. Often a default is provided by your distro of choice, or you may version control your own
dot file. Either way, this library will avoid touching these files when possible and support the use of `config.d` style
includes, which provide minimal impact to your top-most config files.

> [!TIP]
> each group that sets a config file in either `~/.bashrc.d/` or `~/.zshrc.d` will use the practice of using the group
> name of the thing being installed as the config file name.
> E.g. `tuckr add starship` will add a `~/.bashrc.d/starship.bash` config file via symlink

## Git'isms and DEFAULT_CODE_DIR

The git config provided prompts for a `DEFAULT_CODE_DIR` location, which is typically a directory where all your repos
get cloned to. You do clone all your repos to a single directory right? And not to the desktop and all over the place??

This git config takes it a step further and separates "work" from "private" locations and includes username and email
credentials based on this structure.

For example, if you take the default `DEFAULT_CODE_DIR=~/code` setting. Then this gitconfig will assume all your 'work'
repos sit under `~/code/work` and similarly all your private repos are under `~/code/private`.

To take it another step further, the gitconfig supplied offers some nice function aliases to provide further
organisation.

`git clone-private` and `git clone-work` will clone the supplied repository, with the full path, under the respective
`~/code/private` and `~/code/work` directories.

For example, running the following on this repo (which is where the installer will put it by default)

```bash
git clone-private https://github.com/vasdee/dotfiles.git

```

Will result in the `dotfiles` repo being located at `~/code/private/github.com/vasdee/dotfiles`

Is it a bit java and dotnetty namespace looking? Kinda. Does it make things easier when you are dealing with a lot of
enterprise level repositories scattered all over the place? Absolutely!

To make it even easier to navigate, if you are using `bash` or `zsh` via this repo, you will get a nice interactive
navigator via the alias, `gitchooser`

> [!NOTE]
> The git group prompts during the run of tuckr set git for the variables to populate localsettings
> You can always manually edit this file

## Passwords

I like using a `~/.netrc` file as my single source of truth for credential management. Others might not, but either
way I like to keep the contents of that file within a dedicated password manager, rather than keep it within these dots,
which is an option with `tuckr`

## Supported installs

| Software group       | Description                                                                         |
|:---------------------|:------------------------------------------------------------------------------------|
| azure-cli            | Official Azure CLI                                                                  |
| awscli               | Official AWS CLI                                                                    |
| docker               | Docker community edition engine & CLI tooling                                       |
| docker-cli           | Docker CE CLI tooling only, no engine install                                       |
| uv                   | Python dependency management                                                        |
| ruff                 | extremely fast linter for python                                                    |
| just                 | a command runner, inspired by make but much better                                  |
| starship             | a terminal prompt prettier, written in rust                                         |
| ripgrep              | A faster, enhanced version of grep. Often integrated into editors                   |
| nvm                  | manage multiple node versions                                                       |
| pre-commit           | run checks and validation before committing to git                                  |
| poetry               | a perfectly fine python project management tool, but deprecated in favour of uv now |
| trivy                | container image scanning tool                                                       |
| bash                 | some nice, minimal configuration for bash shells                                    |
| zsh                  | some nice, minimal configuration for zsh shells                                     |
| lazydocker           | tui for managing local docker containers                                            |
| gitu                 | TUI for git interaction, based on magit                                             |
| editorConfig         | default editor configurations for maintaining consistency between teams             |
| direnv               | manage environment variables per directory                                          |
| git                  | some nice configuration specifically for work                                       |
| oras                 | CLI tool for interfacing with OCI objects                                           |
| bump-my-version      | CLI for applying semver practices to git repos                                      |
| cruft                | CookieCutter template manager                                                       |
| ansible              | Configuration automation tool for                                                   |
| dive                 | TUI tool for inspecting docker images                                               |
| pandoc               | Markup conversion tool                                                              |
| watchexec            | monitor file changes and run commands                                               |
| glab                 | gitlab CLI tool for interacting with gitlab apis                                    |
| pyright              | M$ Python Language server                                                           |
| basedpyright         | A based version of the pyright lang server with saner defaults                      |
| rumdl                | A modern Markdown linter and formatter, built for speed with Rust                   |
| nodejs               | Javascript runtime (mainly used for managing packages via this tool) see NVM        |
| ty                   | An extremely fast python type checker and language server from astral               |
| bash-language-server | LSP server for bash and sh                                                          |
| just-lsp             | LSP server for Just                                                                 |
| tmux                 | A terminal multiplexer                                                              |
| fd                   | fd is a fast find alternative written in rust                                       |
| fzf                  | fast fuzzy finder utility                                                           |
| shellcheck           | a static analysis tool for shell scripts                                            |
| delta                | a syntax-highlighting pager for git, diff, and grep output                          |
| yay                  | AUR helper for Arch-based systems (arch, steamos)                                   |
|                      |                                                                                     |

> [!TIP]
> All can be installed and configured via `tuckr set <name of group>`

## Notes on Install

Some of the installs might prompt or include some extras that you did not know about. Anything of note
is detailed below.

### Installing specific versions

While the most common use case for these dots if or bootstrapping a local dev machine, there is a potential use case for
using these dot installers within a container build.

For local dev, it is usually perfectly fine to install the latest of whatever software you are installing, and that is
why it is the default. For those odd times where you require a specific version of a piece of software, then _most_ of
the installs support installing a specific version via supplying an env var of the form `$<PACKAGE NAME>_VERSION`

For example, the following will attempt to install `poetry` version 1.8.2, in this case via `uv`

`POETRY_VERSION=1.8.2 tuckr set poetry`

### Docker community edition

Installs docker engine, cli and all the bits and pieces required for docker development.

The docker install occurs via the recommended way via <https://docs.docker.com/engine/install/>

`tuckr set docker`

If you want just the CLI tooling for docker, minus the engine - particularly useful in docker pipeline builds,
then the docker-cli target is an alternative.

### Install uv

Installing uv is a requirement for other tools, such as pre-commit, ruff, poetry and just.

The install occurs via the currently recommended way on <https://docs.astral.sh/uv/getting-started/installation/>

`tuckr set uv`

### Various UV tools

Tools like pre-commit, just, ruff, ansible etc which can be installed via the `uv tool install`.

This is considered best practice for non system wide installs and hence is the preferred method when available

> [!Note]
> Once tools are installed this way, be sure to periodically update them via_ `uv tool update`
> or by running the _set_ hook again for that group.

### editorConfig

A root level editorConfig is supplied and will be installed in `$DEFAULT_CODE_DIR`

> [!IMPORTANT]
> In order for this root revel editorConfig to take effect, any custom editorConfigs within your
> repo ( or other locations ) should set `root = false` in order for these defaults to be discovered.
> The most simplest form of this is to add a blank `.editorconfig` into your repo

### Shells BASH and ZSH

Both can be installed and basically configured via their respective groups `bash` and `zsh`

Other tools that require bash or zsh integration manage their own configuration for the shells, for instance
`starship`. In order to keep this consistent, the generally well accepted practice of organsing your custom
import shell scripts under a specifc directory is adopted and setup during the first run

For bash, custom scripts should be placed in `~/.bashrc.d/` while for zsh, it is `~/.zshrc.d/`

Some distributions already adopt this practice, in which case nothing else needs to be done. For those that don't,
the addition is contained with a `.bashrc-custom` or `.zshrc-custom` file and the source line is automatically appended
to `.bashrc` or `.zshrc`.

### Git config

On the off chance you want to work with work and personal accounts on the same machine, provisions have been made to
cater for both configs.

This repository assumes that you will use the `git clone-work` or `git clone-private` alias to clone ALL repositories,
both personal and work related. This will make organising mostly straight forward as _most_ people will use github.com
for personal and gitlab.com for work related.

### Global gitignore

The git hook also downloads and consolidates common `.gitignore` rules into `$HOME/.config/git/ignore`

The list comes from <https://github.com/github/gitignore> and the currently consolidated ones can be added to within the
[Hooks/git/post.sh](Hooks/git/post.sh) hook script

> [!NOTE]
> The global ignore can always be tailored to suit a per-project `.gitignore` by negating a rule
> using the ! operator

### Pandoc

Gitlab and Github both use extensions to markdown that are not 100% compatible.

Unless you want to jump back and forth between the online Gitlab markdown editor, you can also get a decent
representation via using `pandoc`

Installing `pandoc` will also install the github html rendering template, which is much better than stock standard.

For a "good enough" local verification of a readme file that will render in Gitlab, you can run the following.

```shell
pandoc \
    --metadata=title=markdown \
    --template=GitHub.html5 \
    --from gfm \
    --to html5 \
    --mathjax \
    --highlight-style=pygments \
    --standalone \
    -o preview.html 
    readme.md
```

which is also provided as an alias, provided you have installed the bash or zsh group previously:

```shell
pandoc-preview readme.md
```

For bonus points, you can also run `watchexec` and have the preview.html auto-reload in your browser

```shell
watchexec readme.md pandoc-preview readme.md
```

### Ruff

A global `ruff.toml` file is provided within `~/.config/ruff/ruff.toml` which contains some commonly accepted standards.

Consider extending the global file when developing in order to not have to duplicate the same settings across projects.

An example project level `pyproject.toml`

``` toml
[tool.ruff]
# Extend the `pyproject.toml` file in the user config directory...
extend = "~/.config/ruff/pyproject.toml"
```

OR

An example project level `ruff.toml`

``` toml
# Extend the `ruff.toml` file in the user config directory...
extend = "~/.config/ruff/ruff.toml"

# ...but use a different line length.
line-length = 100
```

See here for more information on the limits of how this config file discovery works

<https://docs.astral.sh/ruff/configuration/#config-file-discovery>

### Rumdl

Rumdl is a fast markdown linter and LSP server. It is backwards compatible with `markdownlint`, aka `mdl`.

A global `rumdl.toml` is provided as part of the install. Unlike ruff, it cannot be extended in a per-project basis, so
it might not be as useful.

A potential pattern for using `rumdl` within `pre-commit` checks in a pipeline for instance, is to install the `rumdl`
config during the pipeline

### Emacs

Run these after first boot of emacs `M-x all-the-icons-install <RETURN>` and `M-x nerd-icons-install <RETURN>`

## Usage within docker builds

``` dockerfile
FROM debian:trixie as build

RUN curl -sL https://raw.githubusercontent.com/vasdee/dotfiles/install.sh | bash && \
    tuckr set uv pre-commit ruff

FROM debian:trixe as run

RUN cp --from build 

```

## Adding new Hooks and Configs

For anything that requires more than just a config file, use the hooks features to provide installs.

`lib/lib.sh` will give you a good starting point for how to structure installs based on the linux distro or osx

Before adding anything extra into the basics group, consider if it is truly required. Otherwise make it optional in its
own group

If root privileges are required for any installs, rather than specifying `sudo`, considering using the provided function
`rootdo`, which will check if the current user is root, and run the command with or without sudo depending on the user.

This is very useful particularly when using it within dockerfiles, which typically are built with root

The following is the list of supported hooks that can be used for installing software. The name of the hook is
based on the `ID` field from `/etc/os-release` on linux, or `sw_vers -productName` on MacOS

`fedora() {}` - fedora specific install, using dnf for example

`debian() {}` - debian specific install, using apt for example

`ubuntu() {}` - ubuntu specific install, often this can just call `debian`

`steamos() {}` - steam os specific install, which is built on arch

`macos() {}` - macos specific install hook. Could use brew install if required

`linux() {}` - a linux installer, useful for things that might use a pre-compiled linux binary for instance

`generic() {}` - a generic installer hook, when doing curl-sudo-pipe-bash installs or perhaps when using `uv tool` as
the install target

If using `uv tool` to install software, a convenience function is provided that will ensure `uv` is installed.

```bash
uv_install() {
    has uv
    ... 
    uv tool install $*
}
```

> [!NOTE]
> The `uv tool` install also respects package versions, which can be set via `$<PACKAGE NAME>_VERSION`
> For example, `RUFF_VERSION=1.0.0 tuckr set ruff` will install the equivalent of `uv tool install ruff==1.0.0`

If using `npm` to install software, then a convenience function is provided that will ensure `npm` is installed and
packages end up on the standard `~/.local/` prefix

``` bash
npm_install() {
    has npm
    ...
    npm install --global ...
}
```

> [!NOTE]
> The `npm install --global` install also respects package versions, which can be set via `$<PACKAGE NAME>_VERSION`
> For example, `BASH_LANGUAGE_SERVER_VERSION=1.0.0 tuckr set bash-language-server` will install the equivalent of
> `npm install --global bash-language-server@1.0.0`

For `npm` and `uv` based installs, an equivalent of `npm_uninstall` and `uv_uninstall` exists to be used within removal
scripts.

## lib.sh functions

There are some handy functions included in [lib/lib.sh](lib/lib.sh) that are worth exploring but included here as well

## Updating local tuckr as new version emerge

Will differ depending on OS flavour, but the general gist is to have cargo installed and build tuckr.

This then gets copied to the appropriate bin location

```text
sudo dnf install cargo
cargo install tuckr
mv ~/.cargo/bin/tuckr ~/.config/dotfiles/bin/$(uname -s)/$(uname -m)/
TUCKR_VERSION=$(tuckr --version)
git commit -m "updated ${TUCKR_VERSION// /-}"
```
