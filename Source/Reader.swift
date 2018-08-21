import UIKit

class Reader {
    init() {
        
    }
    
    func read(image:UIImage) throws {
        throw QRheroError.tryingToReadInvalidImage
    }
}
