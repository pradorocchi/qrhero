import UIKit

public class Hero {
    private let reader = Reader()
    private let writer = Writer()
    private let queue = DispatchQueue(label:String(), qos:.background, attributes:.concurrent,
                                      target:.global(qos:.background))
    
    public init() { }
    
    public func read(image:UIImage, result:@escaping((String) -> Void), error:((HeroError) -> Void)? = nil) {
        queue.async { [weak self] in
            guard let reader = self?.reader else { return }
            do {
                let content = try reader.read(image:image)
                DispatchQueue.main.async { result(content) }
            } catch let exception as HeroError {
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
