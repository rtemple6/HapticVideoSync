import Foundation
import UIKit

public protocol HapticFeedbackProtocol {
    func triggerHapticFeedback()
}

public class HapticFeedbackGenerator: HapticFeedbackProtocol {
    public func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}
