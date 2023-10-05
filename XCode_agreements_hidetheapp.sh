#!/bin/sh

#Accept the agreements
xcodebuild -license accept
xcode-select -s /Applications/Xcode.app/Contents/Developer

#Hide the app
chflags hidden /Applications/Xcode.app

exit 0
