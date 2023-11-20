import XCTest
@testable import HapticVideoSync
import AVFoundation

final class HapticVideoSyncTests: XCTestCase {

    var hapticVideoSync: HapticVideoSync!
    var mockPlayer: MockAVPlayer!
    var mockHapticFeedbackGenerator: MockHapticFeedbackGenerator!

    override func setUp() {
        super.setUp()
        mockPlayer = MockAVPlayer()
        mockHapticFeedbackGenerator = MockHapticFeedbackGenerator()
        let timestamps = [1.0, 2.0, 3.0]
        hapticVideoSync = HapticVideoSync(player: mockPlayer, hapticFeedbackGenerator: mockHapticFeedbackGenerator, timestampsInSeconds: timestamps)
    }

    override func tearDown() {
        hapticVideoSync = nil
        mockPlayer = nil
        super.tearDown()
    }

    func testHapticFeedbackTriggeredAtCorrectTimes() {
        // Simulate video playback and check if haptic feedback is triggered at correct times
        simulatePlayback(atTime: 1.0)
        XCTAssertTrue(mockHapticFeedbackGenerator.didTriggerHapticFeedback)

        simulatePlayback(atTime: 2.0)
        XCTAssertTrue(mockHapticFeedbackGenerator.didTriggerHapticFeedback)
    }

    private func simulatePlayback(atTime time: Double) {
        mockPlayer.currentTime = CMTimeMakeWithSeconds(time, preferredTimescale: 1000)
        hapticVideoSync.checkForHapticTrigger(time: mockPlayer.currentTime)
    }
}

class MockAVPlayer: AVPlayer {
    var currentTime: CMTime = CMTime.zero
}

class MockHapticFeedbackGenerator: HapticFeedbackProtocol {
    var didTriggerHapticFeedback = false
    
    func triggerHapticFeedback() {
        didTriggerHapticFeedback = true
    }
}
