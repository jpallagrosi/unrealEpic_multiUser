# UE5

3 Components needed: Epic Games Launcher, Unreal Engine 5, XCode.

Epic Games Launcher and Unreal Engine 5
Snapshot the install of both Epic Games Launcher Unreal Engine 5. \
Install Unreal Engine 5 from the Epic Games Launcher. \
(Drag and drop didn't work for me) \
An Epic Games account is required for the above. It is free to sign up.

XCode
Scope in the app store via a static group. \
Agrements an hide the app script. Scoped "Once per user per computer" \
If XCode is beeing used separatly to Unreal this might not work for you.

Add the script unrealEpic_multiUser.sh in the same policy as the package. \
This will install both the LaunchAgent and the script epicManifests_cp.sh in the correct locations.
