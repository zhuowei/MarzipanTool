#!/bin/bash
set -e
rm -r swiftstdlib || true
mkdir swiftstdlib
for i in /Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphonesimulator/*.dylib
do
	echo $i
	localname="swiftstdlib/$(basename "$i")"
	# lipo to x86_64 only
	lipo "$i" -output "$localname" -thin x86_64
	# first, change the link type
	python changelinktype.py "$localname" "$localname"
	install_name_tool \
		-change /System/Library/Frameworks/MapKit.framework/MapKit \
		/System/iOSSupport/System/Library/Frameworks/MapKit.framework/MapKit \
		-change /System/Library/Frameworks/MetalKit.framework/MetalKit \
		/System/iOSSupport/System/Library/Frameworks/MetalKit.framework/MetalKit \
		-change /System/Library/Frameworks/UIKit.framework/UIKit \
		/System/iOSSupport/System/Library/Frameworks/UIKit.framework/UIKit \
		"$localname"
done
