# WebRTC iOS Binary Swift Package

forked from https://github.com/alexpiezo/WebRTC.

## Versions

This repo adopts the following version scheme. 

`1.<release>.0` - where release is a WebRTC release. For example, M91 will be tagged as `1.91.0`

We also publish a separate major version with LiveKit specific patches: `2.<release>.0`. Details of the changes in this branch can be found [here](https://github.com/livekit/webrtc-ios)

## Installation

### Swift Package Manager

Requires Swift 5.3 / Xcode 12+.

Add WebRTC repository https://github.com/livekit/WebRTC.git via Swift Package Manager

Alternatively, to integrate via a Package.swift manifest instead of Xcode, you can add WebRTC to your dependencies array of your package with

```swift
dependencies: [
    .package(url: "https://github.com/livekit/WebRTC-swift.git", .upToNextMajor(from: "1.91.0"))
]
```

Then add a new run script phase script to your app’s target

```shellscript
find "${CODESIGNING_FOLDER_PATH}" -name '*.framework' -print0 | while read -d $'\0' framework
do
    codesign --force --deep --sign "${EXPANDED_CODE_SIGN_IDENTITY}" --preserve-metadata=identifier,entitlements --timestamp=none "${framework}"
done
```

### Building your own manually

#### Download webrtc

```shellscript
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$PATH:/path/to/depot_tools

fetch --nohooks webrtc_ios

cd src

git branch -r
git checkout branch-heads/BRANCH

gclient sync
```

#### Generate iOS and macOS targets

```shellscript
# Build libs for desired arch
./tools_webrtc/ios/build_ios_libs.py  --arch arm64 x64

# Generate XCFramework
xcodebuild -create-xcframework \
	-framework out_ios_libs/arm64_libs/WebRTC.framework \
	-framework out_ios_libs/x64_libs/WebRTC.framework \
	-output out_ios_libs/WebRTC.xcframework
```
