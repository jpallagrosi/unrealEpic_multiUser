#!/bin/zsh

#It will wait until the logged in user opens Epic to move the manifests files and prompt them to relaunch it

loggedInUser=$(ls -l /dev/console | awk '{print$3}')
localAdmin=its
#epicLibrary="/Users/$loggedInUser/Library/Application\ Support/Epic/"

if [ -d /Users/$loggedInUser/Library/Application\ Support/Epic/ ]
	then 
		echo "Epic directory already exists."
	else
		until [ -d /Users/$loggedInUser/Library/Application\ Support/Epic/ ]
    		do
           		echo "Epic directory not found. Waiting..."
        		sleep 3
    		done

        echo "Epic directory found. Proceeding..."
        sleep 3

        mkdir -p "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data"
        cp -R "/Users/$localAdmin/Library/Application Support/Epic/EpicGamesLauncher/Data/Manifests" "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data/"

		sleep 7
		osascript  -e 'display dialog "Please restart the Epic Games Launcher to enable full functionality." buttons {"Restart EPIC"} default button 1'
		pkill Epic Games Launcher
		sleep 3
		Open /Applications/Epic\ Games\ Launcher.app

fi

exit 0
