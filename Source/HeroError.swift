import Foundation

public enum HeroError:LocalizedError {
    case tryingToReadInvalidImage
    case imageHasNoQrCode
    
    public var errorDescription:String? { return String(describing:self) }
}
