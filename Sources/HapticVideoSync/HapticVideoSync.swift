import AVFoundation
import UIKit

public class HapticVideoSync {
    private var player: AVPlayer
    private var hapticFeedbackGenerator: HapticFeedbackProtocol
    private var displayLink: CADisplayLink?
    private var hapticTimestamps: [CMTime]
    private var lastTriggeredTimeIndex = 0

    public init(player: AVPlayer, hapticFeedbackGenerator: HapticFeedbackProtocol, timestampsInSeconds: [Double]) {
        self.player = player
        self.hapticFeedbackGenerator = hapticFeedbackGenerator
        self.hapticTimestamps = timestampsInSeconds.map { CMTimeMakeWithSeconds($0, preferredTimescale: 1000) }
        setupDisplayLink()
    }

    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .default)
    }

    @objc private func update() {
        let currentTime = player.currentTime()

        if lastTriggeredTimeIndex < hapticTimestamps.count &&
           currentTime >= hapticTimestamps[lastTriggeredTimeIndex] {

            hapticFeedbackGenerator.triggerHapticFeedback()
            lastTriggeredTimeIndex += 1
        }
    }

    deinit {
        displayLink?.invalidate()
    }
    
    // MARK: - Testing helper method
    
    public func testUpdate() {
        update()
    }
}
