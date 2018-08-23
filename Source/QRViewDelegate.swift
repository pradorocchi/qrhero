import Foundation

public protocol QRViewDelegate:AnyObject {
    func qrCancelled()
}

public extension QRViewDelegate {
    func qrCancelled() { }
}
