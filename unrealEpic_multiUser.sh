#!/bin/zsh

#set -x

#Creates the script to copy the manifests files into the logged in user's library

#The script will wait until the logged in user opens Epic to move the manifests files
#User will be prompt to relaunch the app
cd /usr/local/

echo '#!/bin/zsh
loggedInUser=$(ls -l /dev/console | awk '\''{print$3}'\'')
localAdmin=
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

exit 0' > epicManifests_cp.sh

chmod +x /usr/local/epicManifests_cp.sh
chown root:wheel /usr/local/epicManifests_cp.sh

#Creates the LaunchAgent to trigger the script
cd /Library/LaunchAgents/

echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.epic.manifests</string>
	<key>ProgramArguments</key>
	<array>
		<string>/usr/local/epicManifests_cp.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>' > com.epic.manifests.plist

chmod 644 /Library/LaunchAgents/com.epic.manifests.plist
chown root:wheel /Library/LaunchAgents/com.epic.manifests.plist

exit 0

