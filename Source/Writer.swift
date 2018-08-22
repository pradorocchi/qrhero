import UIKit
import CoreImage

class Writer {
    func write(content:String) -> UIImage? {
        var image:UIImage?
        if  let cgImage:CGImage = self.cgImage(content:content) {
            image = UIImage(cgImage:cgImage, scale:Constants.saveScale, orientation:UIImage.Orientation.up)
        }
        return image
    }
    
    private func cgImage(content:String) -> CGImage? {
        var image:CGImage?
        if let ci:CIImage = self.filter(content:content)?.outputImage?.transformed(
            by:CGAffineTransform(scaleX:Constants.scale, y:Constants.scale)) {
            image = CIContext().createCGImage(ci, from:ci.extent)
        }
        return image
    }
    
    private func filter(content:String) -> CIFilter? {
        let filter:CIFilter? = CIFilter(name:Constants.filter)
        filter?.setValue(Constants.value, forKey:Constants.key)
        if let data:Data = content.data(using:String.Encoding.utf8, allowLossyConversion:false) {
            filter?.setValue(data, forKey:Constants.content)
        }
        return filter
    }
}

private struct Constants {
    static let filter:String = "CIQRCodeGenerator"
    static let key:String = "inputCorrectionLevel"
    static let value:String = "H"
    static let content:String = "inputMessage"
    static let scale:CGFloat = 10.0
    static let saveScale:CGFloat = 1.0
}
