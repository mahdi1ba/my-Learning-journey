#!/bin/bash
#simple demo of an input dialog box

# global variables /default variables
MSGBOX=${MSGBOX=dialog}
TITLE="Default"
MESSAGE="Something to display"
XCOORD=10
YCOORD=20

#function declarations - start

funcDisplayInputBox(){
    $MSGBOX --title "$1" --input "$2" "$3" "$4" 2> tmpfile.txt
}

# function declarations - stop

#script -start

funcDisplayInputBox "Display File Name" "Wich file in the current directory do you want to display ?" "10" "20"

if ["'cat tmpfile.txt'" != "" ]; then
    cat "'cat tmpfile.txt'"
else
    echo "Nothing to do"
fi
# script - stop
