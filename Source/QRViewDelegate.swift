import Foundation

public protocol QRViewDelegate:AnyObject {
    func qrRead(content:String)
    func qrCancelled()
    func qrError(error:Error)
}

public extension QRViewDelegate {
    func qrRead(content:String) { }
    func qrCancelled() { }
    func qrError(error:Error) { }
}
