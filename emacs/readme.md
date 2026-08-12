# Emacs

              ---===  A N D  T H E  ===---

██╗  ██╗███████╗       ███╗   ███╗ █████╗  ██████╗███████╗
██║  ██║██╔════╝       ████╗ ████║██╔══██╗██╔════╝██╔════╝
███████║█████╗  █████╗ ██╔████╔██║███████║██║     ███████╗
██╔══██║██╔══╝  ╚════╝ ██║╚██╔╝██║██╔══██║██║     ╚════██║
██║  ██║███████╗       ██║ ╚═╝ ██║██║  ██║╚██████╗███████║
╚═╝  ╚═╝╚══════╝       ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝

   ---=== M A S T E R S  O F  T H E  E D I T O R ===---

See [init.el](emacs/config/emacs.d/init.el) and [early-init.el](emacs/config/emacs.d/early-init.el) for the details.
Lots of this config was lifted from other repos over the years, if I can remember them I will reference them.


## Features

The Major components of this setup are:

* eglot - Language Server Protocol (LSP) integrations
* project.el - git project management
* dirvish - replaces dired and also adds a sidebar file tree which is occasionally useful
* vim-tab-bar and one-tab-per-project (otpp) for grouping projects per tab
* magit - of course...
* ~~ivy, swiper, counsel - eventually will explore the new hotness for these~~
* corfu, vertico and the rest
* doom-modeline - it just looks awesome
* tree sitter - for most things, barring YAML mode which seems to be very broken
* theme - doom-one
* flycheck - using the new v38 branch to allow eglot and LSP integration
* emacs-dashboard - 
* rassafrassum - for multiplexing LSP servers into eglot

OS level components like rassafrassum for eglot and the font and icon packs are handled by caifs hooks.

## Good tip for debugging issues with emacs

`emacs --batch -l ~/.emacs.d/init.el -f kill-emacs 2>&1`

## References 

[Chadmacs](https://github.com/Borderliner/Chadmacs) - much inspiration for nice organisation of `init.el`


## TODO

* Configure ghostel buffer to take the name of the current project
* tab-line-mode - restrict to only project buffers that are visited files
* ~~tab-line-mode - truncate tab names to max length
* ~~tab-line-mode - remove the + sign~~
* ~~emacs-dashboard - remove welcome text~~
