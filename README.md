# HapticVideoSync

<img src=https://github.com/rtemple6/HapticVideoSync/assets/7842341/51e49724-29a4-422f-9502-ff160125e9a7 width=200> <img src=https://github.com/rtemple6/HapticVideoSync/assets/7842341/4297cc25-142a-4ff4-b5f7-1eaccfc777ef width=200>


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
```

## Usage

```swift
import HapticVideoSync

// Initialize AVPlayer
let player = AVPlayer(url: videoURL)

// Initialize HapticVideoSync with player and timestamps
let hapticSync = HapticVideoSync(player: player, timestampInSeconds: [2.5, 5.75, 10.0, 10.05, 14.9])

// Play video
player.play()
```

## Contributing

Contributions are welcome! Please submit a pull request.
