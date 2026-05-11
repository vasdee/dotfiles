# Git-dev Target

The git target will ensure the `git` binary is installed, it is handy for unattended installations that require git,
but no extra configuration.

This git-dev target adds nice configuration, intended for a dev workflow

`~/.gitconfig-work`
`~/.gitconfig-private`

## Workflow

After installing, instead of the usual `git clone` method, use the aliases `git clone-work` or `git clone-private` to
clone the repositories into the correct base work directory. eg `$DEFAULT_CODE_DIR/work` or `$DEFAULT_CODE_DIR/private`

## Updating the global ignore file

The currently used script for updating the `~/.config/git/ignore` file is below
It used to be a post-hook script, but it was too dynamic and not idempotent enough. Now it gets managed as config

``` shell
GLOBAL_IGNORES="\
        Global/Ansible.gitignore \
        Global/JetBrains.gitignore \
        Global/Linux.gitignore \
        Global/Emacs.gitignore \
        Global/macOS.gitignore \
        Global/VisualStudioCode.gitignore \
        Global/VirtualEnv.gitignore \
        Global/Windows.gitignore \
        Dotnet.gitignore \
        Python.gitignore \
        Terraform.gitignore \
"

GLOBAL_IGNORE_FILE=config/.config/git/ignore

mkdir -p $(dirname ${GLOBAL_IGNORE_FILE})

# reset the file or create it
> ${GLOBAL_IGNORE_FILE}

echo "Downloading common gitignores from https://github.com/github/gitignore..."
for ignore_file in $GLOBAL_IGNORES; do
    echo "" >> ${GLOBAL_IGNORE_FILE}
    echo "## Start ${ignore_file}" >> ${GLOBAL_IGNORE_FILE}
    curl -sL https://raw.githubusercontent.com/github/gitignore/refs/heads/main/${ignore_file} >> ${GLOBAL_IGNORE_FILE}
    echo "## End ${ignore_file}" >> ${GLOBAL_IGNORE_FILE}
done
```

## Dependencies

You should ensure that you have a `$DEFAULT_CODE_DIR` environment variable set, which by default is generated during
`caifs add bootstrap`


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
git clone-private https://github.com/caifs-org/caifs-common.git

```

Will result in the `dotfiles` repo being located at `~/code/private/github.com/caifs-org/caifs-common`

Is it a bit java and dotnetty namespace looking? Kinda. Does it make things easier when you are dealing with a lot of
enterprise level repositories scattered all over the place? Absolutely!

To make it even easier to navigate, if you are using `bash` or `zsh` via this repo, you will get a nice interactive
navigator via the alias, `gitchooser`

> [!NOTE]
> The git target will generate two empty ~/.gitconfig-work and ~/.gitconfig-private files to populate after install
