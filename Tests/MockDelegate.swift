import Foundation
@testable import QRhero

class MockDelegate:QRViewDelegate {
    var onCancel:(() -> Void)?
    
    func qrCancelled() {
        self.onCancel?()
    }
}
