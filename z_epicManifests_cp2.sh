#!/bin/bash
loggedInUser=$(ls -l /dev/console | awk '{print$3}')
localAdmin=$4
#epicLibrary="/Users/$loggedInUser/Library/Application\ Support/Epic/"

if [ -d /Users/$loggedInUser/Library/Application\ Support/Epic/ ]
#if [ -d ${!epicLibrary} ]
	then 
		echo "Epic directory already exists."
	else
		until [ -d /Users/$loggedInUser/Library/Application\ Support/Epic/ ]
		#until [ -d ${!epicLibrary} ]
    		do
           		echo "Epic directory not found. Waiting..."
        		sleep 3
    		done

        echo "Epic directory found. Proceeding..."
        sleep 3

        mkdir -p "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data"
		#mkdir -p "${!epicLibrary}/EpicGamesLauncher/Data"
        cp -R "/Users/$localAdmin/Library/Application Support/Epic/EpicGamesLauncher/Data/Manifests" "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data/"
		#cp -R "${!epicLibrary}/EpicGamesLauncher/Data/Manifests" "${!epicLibrary}/EpicGamesLauncher/Data/"

		sleep 7
		osascript  -e 'display dialog "Please restart the Epic Games Launcher to enable full functionality." buttons {"Restart EPIC"} default button 1'
		pkill Epic Games Launcher
		sleep 3
		Open /Applications/Epic\ Games\ Launcher.app

fi

exit 0
