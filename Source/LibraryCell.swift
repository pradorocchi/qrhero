import UIKit
import Photos

class LibraryCell:UICollectionViewCell {
    weak var image:UIImageView!
    var request:PHImageRequestID?
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor(white:1, alpha:0.4)
        clipsToBounds = true
        makeOutlets()
        layoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    override var isSelected:Bool { didSet { update() } }
    override var isHighlighted:Bool { didSet { update() } }
    
    private func makeOutlets() {
        let image = UIImageView()
        image.isUserInteractionEnabled = false
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        addSubview(image)
        self.image = image
    }
    
    private func layoutOutlets() {
        image.topAnchor.constraint(equalTo:topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        image.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        image.rightAnchor.constraint(equalTo:rightAnchor).isActive = true
    }
    
    private func update() {
        if isSelected || isHighlighted { alpha = 0.2 } else { alpha = 1 }
    }
}
