import UIKit
import CoreImage

class Writer {
    private static let filter = "CIQRCodeGenerator"
    private static let key = "inputCorrectionLevel"
    private static let value = "H"
    private static let content = "inputMessage"
    private static let scale:CGFloat = 10
    private static let saveScale:CGFloat = 1
    
    func write(content:String) -> UIImage? {
        var image:UIImage?
        if let cgImage = cgImageFor(content:content) {
            image = UIImage(cgImage:cgImage, scale:Writer.saveScale, orientation:.up)
        }
        return image
    }
    
    private func cgImageFor(content:String) -> CGImage? {
        var image:CGImage?
        if let ci = filter(content:content)?.outputImage?.transformed(by:
            CGAffineTransform(scaleX:Writer.scale, y:Writer.scale)) {
            image = CIContext().createCGImage(ci, from:ci.extent)
        }
        return image
    }
    
    private func filter(content:String) -> CIFilter? {
        let filter = CIFilter(name:Writer.filter)
        filter?.setValue(Writer.value, forKey:Writer.key)
        if let data = content.data(using:.utf8, allowLossyConversion:false) {
            filter?.setValue(data, forKey:Writer.content)
        }
        return filter
    }
}
