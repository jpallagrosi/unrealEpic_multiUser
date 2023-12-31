#!/bin/zsh
#idea by jpallagrosi
#set -x
#Creates the script to copy the manifests files into the logged in user's library

#The script will wait until the logged in user opens Epic to move the manifests files
#User will be prompt to relaunch the app
#Set the local admin in Parameter 4

localAdmin="$4"
cp -R /Users/$localAdmin/Library/Application\ Support/Epic/EpicGamesLauncher/Data/Manifests /Users/Shared/
cd /Users/Shared/
mv Manifests .Manifests

cd /usr/local/

echo '#!/bin/zsh

# Function to handle logout
on_logout() {
    echo "User logged out. Exiting script."
    exit 0
}

# Trap the SIGHUP signal (user logout)
trap on_logout SIGHUP

loggedInUser=$(ls -l /dev/console | awk '\''{print$3}'\'')
localAdmin='"$4"'

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
		osascript  -e '\''display dialog "Please restart the Epic Games Launcher to enable full functionality." buttons {"Restart EPIC"} default button 1'\''
		pkill Epic Games Launcher
		sleep 5
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
#The following two commands are work in progress but they should bypass the changes popup for Unreal
#There is propably a way of reducing the permissions to what is only needed. Many files/folders to go through!
chmod -R 777 /Users/Shared/Epic\ Games/UE_5.3
chown -R root:wheel /Users/Shared/Epic\ Games/UE_5.3

exit 0

