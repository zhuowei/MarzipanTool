Not ready.

- disable SIP

Porting a project:

- Must be ObjC for now; I need to fix Swift stdlibs
- put ldwrap in project directory
- Other Linker Flags: -fuse-ld=$(PROJECT_DIR)/ldwrap
- Code Signing: anything is fine (I use Don't Code Sign)
- build for Simulator (iPhone SE is fine)
- Change the bundle ID to com.apple.stocks (I dunno why)

In another terminal

```
sudo ./uikitenabler.sh
```

In yet another terminal:

```
./uikitsystemenabler.sh
```

In Xcode's left panel, go to Products -> (your app.app), Show in Finder, right click, Show Package Contents, open the executable

Virtual machines can't render apps right now, so I will continue testing once I install on real hardware.
