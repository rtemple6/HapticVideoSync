import AVFoundation
import UIKit

public class HapticVideoSync {
    private var player: AVPlayer
    private var hapticFeedbackGenerator: HapticFeedbackProtocol
    
    private var observer: NSKeyValueObservation?
    private var timeObserverToken: Any?
    
    private var hapticTimestamps: [CMTime]
    private var lastTriggeredTimeIndex = 0

    public init(player: AVPlayer, hapticFeedbackGenerator: HapticFeedbackProtocol, timestampsInSeconds: [Double]) {
        self.player = player
        self.hapticFeedbackGenerator = hapticFeedbackGenerator
        self.hapticTimestamps = timestampsInSeconds.map { CMTimeMakeWithSeconds($0, preferredTimescale: 1000) }
        setupPeriodicTimeObserver()
    }
    
    private func setupPeriodicTimeObserver() {
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.checkForHapticTrigger(time: time)
        }
    }
    
    public func checkForHapticTrigger(time: CMTime) {
        if lastTriggeredTimeIndex < hapticTimestamps.count &&
            time >= hapticTimestamps[lastTriggeredTimeIndex] {
            
            hapticFeedbackGenerator.triggerHapticFeedback()
            lastTriggeredTimeIndex += 1
        }
    }

    deinit {
        observer?.invalidate()
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
        }
    }
}
