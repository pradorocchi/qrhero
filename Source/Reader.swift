import UIKit
import CoreImage

class Reader {
    func read(image:UIImage) throws -> String {
        return try self.read(features:self.features(image:image))
    }
    
    private func features(image:UIImage) throws -> [CIFeature] {
        if let image:CIImage = CIImage(image:image) {
            let options:[String:Any] = self.options(image:image)
            if let detector:CIDetector = CIDetector(ofType:CIDetectorTypeQRCode, context:nil, options:options) {
                return detector.features(in:image, options:options)
            }
        }
        throw QRheroError.tryingToReadInvalidImage
    }
    
    private func options(image:CIImage) -> [String:Any] {
        var options:[String:Any] = [CIDetectorAccuracy:CIDetectorAccuracyHigh,
                                    CIDetectorImageOrientation:Constants.orientation]
        if let imageOrientation:Any = image.properties[kCGImagePropertyOrientation as String] {
            options = [CIDetectorImageOrientation:imageOrientation]
        }
        return options
    }
    
    private func read(features:[CIFeature]) throws -> String {
        for feature:CIFeature in features {
            if  let qr:CIQRCodeFeature = feature as? CIQRCodeFeature,
                let message:String = qr.messageString {
                return message
            }
        }
        throw QRheroError.imageHasNoQrCode
    }
}

private struct Constants {
    static let orientation:NSNumber = NSNumber(value:1)
}
