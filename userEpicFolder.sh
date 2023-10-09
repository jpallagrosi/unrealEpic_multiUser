#!/bin/bash

for userName in `ls /Users | grep -v its | grep -v Shared`
do
    if [ -d /Users/$userName/Library/Application\ Support/Epic/ ]
        then 
        echo "<result>Epic Folder</result>"
    else
        echo "<result>No Epic Folder</result>"
    fi

done
