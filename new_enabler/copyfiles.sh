#!/bin/bash
set -e
rm -r output/UIKitSystem.app || true
mkdir -p output
cp -R /System/Library/CoreServices/UIKitSystem.app output/
codesign --remove-signature output/UIKitSystem.app/Contents/MacOS/UIKitSystem
