#!/bin/bash
# installs global copy of modified Swift stdlibs and ldwrap
set -e
echo "Installing to /opt/marzipantool"
./relinkswiftstdlib.sh
mkdir -p /opt/marzipantool
rm -r /opt/marzipantool/swiftstdlib || true
mv swiftstdlib /opt/marzipantool/
cp ldwrap /opt/marzipantool/ldwrap
echo "Installed."
