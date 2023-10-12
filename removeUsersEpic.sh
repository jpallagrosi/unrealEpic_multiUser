#!/bin/bash

# Remove the Epic directory in all users Libraries.
# This in case Epic is already installed and has been opened by users.

for userName in `ls /Users | grep -v "$4" | grep -v Shared`
do
    if [ -d /Users/$userName/Library/Application\ Support/Epic/ ]
        then 
        echo "Removing Epic directory"
        rm -r "/Users/$userName/Library/Application Support/Epic/"
    else
        echo "$userName has not opened Epic"
    fi

done
