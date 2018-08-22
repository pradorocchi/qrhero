import UIKit

public class QRhero {
    private let reader:Reader
    private let writer:Writer
    private let queue:DispatchQueue
    
    public init() {
        self.reader = Reader()
        self.writer = Writer()
        self.queue = DispatchQueue(label:Constants.identifier, qos:DispatchQoS.background,
                                   attributes:DispatchQueue.Attributes.concurrent,
                                   autoreleaseFrequency:DispatchQueue.AutoreleaseFrequency.inherit,
                                   target:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
    
    public func read(image:UIImage, result:@escaping((String) -> Void), error:((Error) -> Void)? = nil) {
        self.queue.async { [weak self] in
            guard let reader:Reader = self?.reader else { return }
            do {
                let content:String = try reader.read(image:image)
                DispatchQueue.main.async { result(content) }
            } catch let exception {
                DispatchQueue.main.async { error?(exception) }
            }
        }
    }
    
    public func write(content:String) -> UIImage? {
        return self.writer.write(content:content)
    }
}

private struct Constants {
    static let identifier:String = "iturbide.QRhero"
}
