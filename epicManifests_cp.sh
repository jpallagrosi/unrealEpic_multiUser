#!/bin/zsh

#It will wait until the logged in user opens Epic to move the manifests files and prompt them to relaunch it

# Function to handle logout
on_logout() {
    echo "User logged out. Exiting script."
    exit 0
}

# Trap the SIGHUP signal (user logout)
trap on_logout SIGHUP

loggedInUser=$(ls -l /dev/console | awk '{print$3}')
localAdmin=

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
        cp -R "/Users/Shared/.Manifests" "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data/Manifests"

		sleep 7
		osascript  -e 'display dialog "Please restart the Epic Games Launcher to enable full functionality." buttons {"Restart EPIC"} default button 1'
		pkill Epic Games Launcher
		sleep 5
		Open /Applications/Epic\ Games\ Launcher.app

fi

exit 0
