import UIKit

public class QRView:UIView {
    public init() {
        super.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    
    required init?(coder:NSCoder) { return nil }
}
