import UIKit

public class QRhero {
    private let reader:Reader
    private let writer:Writer
    
    public init() {
        self.reader = Reader()
        self.writer = Writer()
    }
    
    public func read(image:UIImage) throws -> String {
        return try self.reader.read(image:image)
    }
    
    public func write(content:String) -> UIImage? {
        return self.writer.write(content:content)
    }
}
