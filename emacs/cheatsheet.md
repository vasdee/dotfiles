# Emacs Cheatsheet

# Basic 

C = ctrl
M - alt


# Buffer (unsaved file)

C-x-s Save buffer to file
C-s search for string in buffer
C-x-k kill buffer

C-v scoll page down
M-v scroll page up
C-x z repeat last command ( keep pressing z for more)


# Editing

C-k delete from cursor to end of line

C-e navigate to end of line
C-a navigate to begging of line
C-spc mark region (eg selection)

C-x-C-u upper case selection
C-x-C-l lower case selection 

C-w cut (kill) line
M-w copy line
C-y paste current last line

C-/ undo 
C-_ undo
C-g C-_ redo  ( then use repeat C-x z to call as required) 

C-c > indent (might be python-mode only)
C-c < unindent (might be python-mode only)

# Frame

C-x 5 f open file in new frame
C-x 5 2 create new frame (empty)
C-x 5 0 close frame


# Window

C-x 3 Split Window Vertically

C-x 2 Split Window Horizontally 

C-x 0 Close window

C-x o Navigate to other window

C-x { increase current window size right
C-x } increase current window size left


# Elpy

M-. go to definition
M-, jump back from where the go to definition was called
M-\<left\> unindent
M-\<right\> indent


# Rjsx
M-. go to definition
M-, jump back from definition
    indent?
    unindent

# Neotree

H show hidden files
g refresh
U up a directory
C-c C-c change root directory
C-c C-n Create a file or create a directory if filename ends with a ‘/’
C-c C-d Delete a file or a directory.
C-c C-r Rename a file or a directory.
C-c C-p Copy a file or a directory.
