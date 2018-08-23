import UIKit
import CoreImage

class Reader {
    private static let orientation = NSNumber(value:1)
    
    func read(image:UIImage) throws -> String {
        return try read(features:features(image:image))
    }
    
    private func features(image:UIImage) throws -> [CIFeature] {
        if let image = CIImage(image:image) {
            let options = optionsFor(image:image)
            if let detector = CIDetector(ofType:CIDetectorTypeQRCode, context:nil, options:options) {
                return detector.features(in:image, options:options)
            }
        }
        throw QRheroError.tryingToReadInvalidImage
    }
    
    private func optionsFor(image:CIImage) -> [String:Any] {
        var options:[String:Any] = [CIDetectorAccuracy:CIDetectorAccuracyHigh,
                                    CIDetectorImageOrientation:Reader.orientation]
        if let imageOrientation = image.properties[kCGImagePropertyOrientation as String] {
            options = [CIDetectorImageOrientation:imageOrientation]
        }
        return options
    }
    
    private func read(features:[CIFeature]) throws -> String {
        for feature in features {
            if  let qr = feature as? CIQRCodeFeature,
                let message = qr.messageString {
                return message
            }
        }
        throw QRheroError.imageHasNoQrCode
    }
}
