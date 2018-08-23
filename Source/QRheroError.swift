import Foundation

public enum QRheroError:LocalizedError {
    case tryingToReadInvalidImage
    case imageHasNoQrCode
    
    public var errorDescription:String? { return String(describing:self) }
}
