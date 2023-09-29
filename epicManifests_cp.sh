#!/bin/zsh

#set -x

loggedInUser=$(ls -l /dev/console | awk '{print$3}')

until [ -d /Users/$loggedInUser/Library/Application\ Support/Epic/ ]
    do
        sleep 3
    done

sleep 3

mkdir -p "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data"
cp -R "/Users/its/Library/Application Support/Epic/EpicGamesLauncher/Data/Manifests" "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data/"

exit
