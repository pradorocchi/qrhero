import Foundation
@testable import QRhero

class MockDelegate:QRViewDelegate {
    var onRead:(() -> Void)?
    var onCancel:(() -> Void)?
    
    func qrRead(content:String) {
        onRead?()
    }
    
    func qrCancelled() {
        onCancel?()
    }
}
