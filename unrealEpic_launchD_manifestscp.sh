#!/bin/zsh

#set -x

cd /usr/local/

echo '#!/bin/zsh

loggedInUser=$(ls -l /dev/console | awk '{print$3}')
localAdmin=

until [ -d /Users/$loggedInUser/Library/Application\ Support/Epic/ ]
    do
        sleep 3
    done

sleep 3

mkdir -p "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data"
cp -R "/Users/$localAdmin/Library/Application Support/Epic/EpicGamesLauncher/Data/Manifests" "/Users/$loggedInUser/Library/Application Support/Epic/EpicGamesLauncher/Data/"

exit 0' > epicManifests_cp.sh

chmod +x /usr/local/epicManifests_cp.sh
chown root:wheel /usr/local/epicManifests_cp.sh

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

