import Foundation

public protocol QRViewDelegate:AnyObject {
    func qrRead(content:String)
    func qrCancelled()
    func qrError(error:QRheroError)
}

public extension QRViewDelegate {
    func qrRead(content:String) { }
    func qrCancelled() { }
    func qrError(error:QRheroError) { }
}
