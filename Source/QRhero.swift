import UIKit

public class QRhero {
    private let reader:Reader
    private let writer:Writer
    private let queue:DispatchQueue
    
    public init() {
        reader = Reader()
        writer = Writer()
        queue = DispatchQueue(label:"iturbide.QRhero", qos:.background, attributes:.concurrent, autoreleaseFrequency:
            .inherit, target:.global(qos:.background))
    }
    
    public func read(image:UIImage, result:@escaping((String) -> Void), error:((QRheroError) -> Void)? = nil) {
        queue.async { [weak self] in
            guard let reader = self?.reader else { return }
            do {
                let content = try reader.read(image:image)
                DispatchQueue.main.async { result(content) }
            } catch let exception as QRheroError {
                DispatchQueue.main.async { error?(exception) }
            } catch { }
        }
    }
    
    public func write(content:String, result:@escaping((UIImage) -> Void)) {
        queue.async { [weak self] in
            if let image = self?.writer.write(content:content) {
                DispatchQueue.main.async { result(image) }
            }
        }
    }
}
