Update: @biscuitehh released [an easier method](https://github.com/biscuitehh/MarzipanPlatter) for enabling/building iOSMac apps: try that method if this tool doesn't work.

List of interesting Marzipan/iOSMac repos:

- [biscuitehh/MarzipanPlatter](https://github.com/biscuitehh/MarzipanPlatter) - another (easier) method of launching/building Marzipan apps
- [justMaku/marzipan_hook](https://github.com/justMaku/marzipan_hook) - another (crazier) way to launch Marzipan apps by injecting into Voice Memos
- [kirb/iOSMac-Demo](https://github.com/kirb/iOSMac-Demo) - a better tutorial for running Marzipan apps, with a sample app
- [notjosh/Marzipants](https://github.com/notjosh/Marzipants) - React Native on macOS with Marzipan
- [Let me know](https://github.com/zhuowei/MarzipanTool/pulls) of any others!

Tools to build and run iOS UIKit applications on macOS 10.14 Mojave, using the iOSMac framework announced at WWDC.

![screenshot of an iOSMac app](https://worthdoingbadly.com/assets/blog/iosmac/sc1.png)

Usage instructions:

## Initial Setup - Only has to be done once

You will need a Mac running macOS 10.14 Beta, with Xcode 10 Beta installed. (It must be a physical Mac: virtual machines cannot show iOSMac applications, which require GPU acceleration.).

### Disable SIP

You need to disable System Integrity Protection on your computer. You can find tutorials online, such as [this one](https://support.intego.com/hc/en-us/articles/115003523252-How-to-Disable-System-Integrity-Protection-SIP-).

Note that disabling System Integrity Protection makes your Mac **insecure**, but is needed for enabling iOSMac support. Please reenable SIP when you're not running iOSMac applications.

### Select Xcode

Make sure Xcode Beta is selected as the active Xcode.
```
sudo xcode-select --switch /Applications/Xcode-beta.app
```

### Download and Install MarzipanTool

First, install MarzipanTool's Swift libraries and the linker wrapper on your computer. Run
```
git clone https://github.com/zhuowei/MarzipanTool.git
cd MarzipanTool
./installtool.sh
```

Note that this assumes `/usr/local/` is writable. If you have Homebrew installed, it should be writable. If not, run `sudo ./installtool.sh` instead.

## Enabling iOSMac

These steps bypasses macOS's restrictions and allows your own iOSMac applications to run. You need to keep these programs running when you are testing your own iOSMac applications.

First, open Voice Memos to make sure iOS services are started.

After it starts, in one terminal, run 
```
cd MarzipanTool
./uikitsystemenabler.sh
```

You should see something like this:

```
computer:MarzipanTool zhuowei$ ./uikitsystemenabler.sh 
(lldb) process attach --name "UIKitSystem"
Process 604 stopped
* thread #1, queue = 'com.apple.main-thread', stop reason = signal SIGSTOP
    frame #0: 0x00007fff67fb50d6 libsystem_kernel.dylib`mach_msg_trap + 10
```

Open another terminal and run

```
cd MarzipanTool
sudo ./uikitenabler.sh
```
You should see something like
```
computer:MarzipanTool zhuowei$ sudo ./uikitenabler.sh 
dtrace: script 'tracescript.d' matched 1 probe
dtrace: allowing destructive actions
```

Keep these two terminal windows open.

## Porting an application

Apps can be compiled for iOSMac by building a modified Simulator binary using MarzipanTool's linker wrapper.

### Unsupported features

iOSMac only supports a subset of UIKit features. Thus, most nontrivial apps will not run without modification. For example, the [Kickstarter app](https://github.com/kickstarter/ios-oss) can't build due to these missing classes:
- UIWebView - Used by HockeyApp SDK, Facebook SDK, and some pages in the app
- SFSafariViewController - used by the app
- CTTelephonyNetworkInfo - used for analytics
- SLComposeViewController - used for email share
- MFMailComposeViewController - used for email share
- OpenGLES - used by OpenTok for rendering
- AddressBook - used by Stripe SDK

So if your app uses HockeyApp, Facebook SDK, or Stripe SDK, it will fail to build.

In addition, there are many issues, possibly due to differences between the iOS Simulator and iOSMac's build of UIKit:

- a UILabel set to center in Storyboard instead aligns to the right (?!).
- UIScrollViews and UITableViews must have both Scroll Indicators disabled in Storyboard, otherwise the application crashes on launch

Proper iOSMac headers may fix some of these issues.

If you have any advice on shimming/replacing these classes, please [update this guide](https://github.com/zhuowei/MarzipanTool/pulls)!

### Modifying build settings

**Bundle ID**: Change bundle identifier to "com.apple.stocks". (This is required due to a limitation of my approach for enabling iOSMac. Other approaches such as [Hamzasood's bootloader patch](https://twitter.com/hamzasood/status/1004036460150968320) allow [using any bundle id](), but are more difficult to install.)

**Enable linker wrapper**: Go to your project's configuration, choose Build Settings, select All, then search for Other Linker Flags. Add the line

`-fuse-ld=/usr/local/share/marzipantool/ldwrap`

This needs to be done for all targets in your project.

![A screenshot of the configuration page](https://worthdoingbadly.com/assets/blog/iosmac/sc2.png)

**Fix Text Rendering**: Drag the `NSBundle+AppKitCompat.m` file from the MarzipanTool repo (if you're using Objective-C) or the `NSBundle+AppKitCompat.swift` (if Swift) file to your project. Otherwise Storyboard UILabels crash the application.

### Build the application

- Choose iPhone 8 Plus Simulator as the build target device.
- Product -> Clean Build Folder
- Product -> Build

### Run the application

- Make sure that the two enabler scripts are still running, and that lldb is not stuck.
- Open the Products group in Xcode's left side, right click the .app, and select Show in Finder
- Right click and select Show Package Contents
- Double click the main executable to launch app.

## Issues?

If you encounter any problems, please [open an issue](https://github.com/zhuowei/MarzipanTool/issues).

## License

This project is licensed under the MIT License.
