
# populates the ~/.emacs.d/projects file with projects under
# the DEFAULT_CODE_DIR
function populate-emacs-projects {

    PROJECTS=~/.emacs.d/projects
    echo ";;; -*- lisp-data -*-" > $PROJECTS
    echo "(" >> $PROJECTS
    for p in $(gitdirs); do
        echo '("'$p'")' >> $PROJECTS
    done
    echo ")" >> $PROJECTS

    cat $PROJECTS
}
