Not ready.

- disable SIP
- put ldwrap in project directory
- Other Linker Flags: -fuse-ld=$(PROJECT_DIR)/ldwrap
- Code Signing: anything is fine (I use Don't Code Sign)
- build for Simulator (iPhone SE is fine)

In another terminal

```
sudo ./uikitenabler.sh
```

In yet another terminal:

```
./uikitsystemenabler.sh
```

Now launching iOSMac apps brings up the icon, but applicationDidLaunch is never called on the delegate. Sigh.
