#!/bin/bash
set -e
mkdir -p output
sed -e "s@MARZIPANTOOLPATH@$(pwd)@g" templates/not.apple.uikitsystemapp.plist >output/not.apple.uikitsystemapp.plist
launchctl unload ./output/not.apple.uikitsystemapp.plist || true
launchctl load ./output/not.apple.uikitsystemapp.plist
launchctl start not.apple.uikitsystemapp
echo "started"
