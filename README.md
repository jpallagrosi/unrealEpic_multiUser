# Unreal Engine

3 Components needed: Epic Games Launcher - Unreal Engine 5 - XCode.

**Packaging Epic Games Launcher and Unreal Engine:** \
From the local admin, snapshot the install of both Epic Games Launcher (including updates) and Unreal Engine. \
(Drag and drop didn't work for me) \
Package should be around 20GB. \
Install Unreal Engine from the Epic Games Launcher. \
NOTES: \
- An Epic Games account is required for the above. It is free to sign up. \
- Epic Games Launcher must be up to date to avoid changes popups.

**Deployment:** \
Add the post script _unrealEpic_multiUser.sh_ in the same policy as the package. \
**Set the local admin in Parameter 4.** \
This will install both the LaunchAgent _com.epic.manifests.plist_ and the script _epicManifests_cp.sh_ in the correct locations. \
It will also move the Manifests folder to the Shared folder and hide it. \
**XCode:** \
I use the App Store to install it. \
Agrements an hide the app script _xCode_agreements_hidetheapp.sh_ "Once per user per computer" \
NOTE If XCode is beeing used separatly to Unreal this might not work for you.

**What does _epicManifests_cp.sh_ do?** \
I think the Manifests files are the link between UE and Epic. They are generated during the UE installation and unique per install. \
When a new user launches Epic Games it will create an Epic directory in the users library with multiple components in it. \
If the Manifests files are not there, Epic wont see UE even if it is installed.
Packaging and deploying "per user per computer" the above components will crash Epic. \
_epicManifests_cp.sh_ will wait until the logged in user launches Epic, generates the components and then copy the Manifests files from the Shared folder and place it in the logged in user's Library. \
AppleScript will prompt the logged in user to relaunch Epic as often the apps don't sync the first time. \
_epicManifests_cp.sh_ will exit in 2 cases: 1. When the user log out 2. If the user already launched Epic.


**LaunchAgent _com.epic.manifests.plist_** \
This will trigger the script. You don't want to run _epicManifests_cp.sh_ from Jamf otherwise Jamf will hang until Epic is being opened.
_unrealEpic_multiUser.sh_ must be deployed on OOH otherwise the LaunchAgent won't load and therefore _epicManifests_cp.sh_ won't move the files.

NOTE The script _unrealEpic_multiUser.sh_ works if UE is already installed. \
However use _removeUsersEpic.sh_ to remove the Users epic Library. It will also remove some of the Users Epic Games preferences \
**Set the local admin in Parameter 4.** \
If the Epic folder has not been removed _epicManifests_cp.sh_ will exit without moving the Manifests files and the apps won't sync.

I am aware it is not ideal to have a script waiting in the background as Epic might not be launched by the users but this is the best I could do. \
It works for us but might not for other organisations hence why I am making this public to have it tested and improved.

Feel free to log an issue if you have any suggestions to improve the above. \
I have logged a few already, this is still Work In Progress 🙂

TESTED on ARM/Intel, OS13, Laptop&Desktop, versions as follows: / Unreal Engine 5.3.1 / Epic Games Launcher 15.15.0 \
Also tested the _removeUsersEpic.sh_ _unrealEpic_multiUser.sh_ workfow in a Mac lab.
