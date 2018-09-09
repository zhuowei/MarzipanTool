#!/bin/bash
# installs global copy of modified Swift stdlibs and ldwrap
set -e
installpath="/usr/local/share/marzipantool"
echo "Installing to $installpath"
./relinkswiftstdlib.sh
mkdir -p "$installpath"
rm -r "$installpath/swiftstdlib" || true
mv swiftstdlib "$installpath/"
cp ldwrap "$installpath/ldwrap"
echo "Installed."
