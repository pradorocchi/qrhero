import Foundation

public protocol QRViewDelegate:AnyObject {
    func qrRead(content:String)
    func qrCancelled()
    func qrError(error:HeroError)
}

public extension QRViewDelegate {
    func qrRead(content:String) { }
    func qrCancelled() { }
    func qrError(error:HeroError) { }
}
