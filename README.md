# HapticVideoSync

A Swift package for synchronizing haptic feedback with video playback.

## Features

- Sync haptic feedback to specific timestamps in a video.
- High precision timing with `CMTime`.
- Easy integration with AVFoundation's `AVPlayer`.

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/rtemple6/HapticVideoSync.git", .upToNextMajor(from: "1.0.0"))
]
