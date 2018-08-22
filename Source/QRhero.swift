import UIKit

public class QRhero {
    private let reader:Reader
    
    public init() {
        self.reader = Reader()
    }
    
    public func read(image:UIImage) throws -> String {
        return try self.reader.read(image:image)
    }
}
