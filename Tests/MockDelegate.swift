import Foundation
@testable import QRhero

class MockDelegate:QRViewDelegate {
    var onRead:(() -> Void)?
    var onCancel:(() -> Void)?
    var onError:(() -> Void)?
    
    func qrRead(content:String) {
        onRead?()
    }
    
    func qrCancelled() {
        onCancel?()
    }
    
    func qrError(error:QRheroError) {
        onError?()
    }
}
