import UIKit
import QRhero

class Scanner:UIViewController {
    private weak var qrView:QRView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    override var prefersStatusBarHidden:Bool { get { return true } }
    
    private func makeOutlets() {
        let qrView:QRView = QRView()
        self.qrView = qrView
        self.view.addSubview(qrView)
    }
    
    private func layoutOutlets() {
        self.qrView.topAnchor.constraint(equalTo:self.view.topAnchor).isActive = true
        self.qrView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
        self.qrView.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.qrView.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
    }
}
