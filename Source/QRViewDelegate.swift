import Foundation

public protocol QRViewDelegate:AnyObject {
    func qrRead(content:String)
    func qrCancelled()
}

public extension QRViewDelegate {
    func qrRead(content:String) { }
    func qrCancelled() { }
}
