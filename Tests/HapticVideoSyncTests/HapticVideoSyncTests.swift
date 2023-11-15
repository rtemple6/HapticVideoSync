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
        // Example timestamps
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
        mockPlayer.currentTime = CMTimeMakeWithSeconds(1.0, preferredTimescale: 1000)
        hapticVideoSync.testUpdate() // Manually call update to simulate display link tick
        XCTAssertTrue(mockHapticFeedbackGenerator.didTriggerHapticFeedback)

        mockPlayer.currentTime = CMTimeMakeWithSeconds(2.0, preferredTimescale: 1000)
        hapticVideoSync.testUpdate()
        XCTAssertTrue(mockHapticFeedbackGenerator.didTriggerHapticFeedback)

        // Add more assertions as needed
    }
}

// Mock AVPlayer to simulate playback
class MockAVPlayer: AVPlayer {
    var currentTime: CMTime = CMTime.zero
}

// Mock implementation of HapticFeedbackProtocol
class MockHapticFeedbackGenerator: HapticFeedbackProtocol {
    var didTriggerHapticFeedback = false
    
    func triggerHapticFeedback() {
        didTriggerHapticFeedback = true
    }
}
