# Unreal Engine

3 Components needed: Epic Games Launcher, Unreal Engine 5, XCode.

Epic Games Launcher and Unreal Engine 5: \
Snapshot the install of both Epic Games Launcher (including updates) and Unreal Engine 5. Package should be around 20GB. \
Install Unreal Engine 5 from the Epic Games Launcher. \
(Drag and drop didn't work for me) \
An Epic Games account is required for the above. It is free to sign up.

XCode: \
I use the App Store to install it. \
Agrements an hide the app script. "Once per user per computer" \
If XCode is beeing used separatly to Unreal this might not work for you.

Add the script "unrealEpic_multiUser.sh" in the same policy as the package. Set the local admin in Parameter 4\
This will install both the LaunchAgent "com.epic.manifests.plist" and the script "epicManifests_cp.sh" in the correct locations.

NOTE The script "unrealEpic_multiUser.sh" works if UE is already installed. \
However use "removeUsersEpic.sh" to remove the Users epic Library. \
If the Epic folder is already there "epicManifests_cp.sh" will exit without moving the Manifest files.
