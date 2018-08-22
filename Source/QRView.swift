import UIKit

public class QRView:UIView {
    private weak var camera:UIView!
    private weak var library:UIView!
    private weak var buttonCancel:UIButton!
    private weak var buttonCamera:UIButton!
    private weak var buttonLibrary:UIButton!
    private weak var border:UIView!
    private weak var separator:UIView!
    
    public init() {
        super.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.backgroundColor = UIColor.black
        self.makeOutlets()
        self.layuoutOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func makeOutlets() {
        let camera:UIView = UIView()
        camera.isUserInteractionEnabled = false
        camera.translatesAutoresizingMaskIntoConstraints = false
        self.camera = camera
        self.addSubview(camera)
        
        let library:UIView = UIView()
        library.isUserInteractionEnabled = false
        library.translatesAutoresizingMaskIntoConstraints = false
        library.isHidden = true
        self.library = library
        self.addSubview(library)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.addTarget(self, action:#selector(self.doCancel), for:UIControl.Event.touchUpInside)
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(UIColor.white, for:UIControl.State.normal)
        buttonCancel.setTitleColor(UIColor(white:1.0, alpha:0.2), for:UIControl.State.selected)
        buttonCancel.setTitleColor(UIColor(white:1.0, alpha:0.2), for:UIControl.State.highlighted)
        buttonCancel.setTitle(Constants.cancel, for:UIControl.State())
        buttonCancel.titleLabel!.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.bold)
        self.buttonCancel = buttonCancel
        self.addSubview(buttonCancel)
        
        let buttonCamera:UIButton = UIButton()
        buttonCamera.addTarget(self, action:#selector(self.doCamera), for:UIControl.Event.touchUpInside)
        buttonCamera.translatesAutoresizingMaskIntoConstraints = false
        buttonCamera.setTitleColor(UIColor.white, for:UIControl.State.normal)
        buttonCamera.setTitleColor(UIColor(white:1.0, alpha:0.2), for:UIControl.State.selected)
        buttonCamera.setTitleColor(UIColor(white:1.0, alpha:0.2), for:UIControl.State.highlighted)
        buttonCamera.setTitle(Constants.camera, for:UIControl.State())
        buttonCamera.titleLabel!.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.bold)
        buttonCamera.isSelected = true
        self.buttonCamera = buttonCamera
        self.addSubview(buttonCamera)
        
        let buttonLibrary:UIButton = UIButton()
        buttonLibrary.addTarget(self, action:#selector(self.doCancel), for:UIControl.Event.touchUpInside)
        buttonLibrary.translatesAutoresizingMaskIntoConstraints = false
        buttonLibrary.setTitleColor(UIColor.white, for:UIControl.State.normal)
        buttonLibrary.setTitleColor(UIColor(white:1.0, alpha:0.2), for:UIControl.State.selected)
        buttonLibrary.setTitleColor(UIColor(white:1.0, alpha:0.2), for:UIControl.State.highlighted)
        buttonLibrary.setTitle(Constants.library, for:UIControl.State())
        buttonLibrary.titleLabel!.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.bold)
        self.buttonLibrary = buttonLibrary
        self.addSubview(buttonLibrary)
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.white
        self.border = border
        self.addSubview(border)
        
        let separator:UIView = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.isUserInteractionEnabled = false
        separator.backgroundColor = UIColor.white
        self.separator = separator
        self.addSubview(separator)
    }
    
    private func layuoutOutlets() {
        self.camera.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.camera.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.camera.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.camera.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        
        self.library.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.library.bottomAnchor.constraint(equalTo:self.bottomAnchor).isActive = true
        self.library.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.library.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        
        self.buttonCancel.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.buttonCancel.bottomAnchor.constraint(equalTo:self.border.topAnchor).isActive = true
        self.buttonCancel.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.buttonCancel.widthAnchor.constraint(equalToConstant:Constants.buttonWidth).isActive = true
        
        self.buttonLibrary.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.buttonLibrary.bottomAnchor.constraint(equalTo:self.border.topAnchor).isActive = true
        self.buttonLibrary.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.buttonLibrary.widthAnchor.constraint(equalToConstant:Constants.buttonWidth).isActive = true
        
        self.buttonCamera.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        self.buttonCamera.bottomAnchor.constraint(equalTo:self.border.topAnchor).isActive = true
        self.buttonCamera.rightAnchor.constraint(equalTo:self.separator.leftAnchor).isActive = true
        self.buttonCamera.widthAnchor.constraint(equalToConstant:Constants.buttonWidth).isActive = true
        
        self.border.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.barHeight).isActive = true
        self.border.leftAnchor.constraint(equalTo:self.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.rightAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        self.separator.topAnchor.constraint(equalTo:self.topAnchor, constant:Constants.separator).isActive = true
        self.separator.topAnchor.constraint(equalTo:self.border.topAnchor,
                                            constant:-Constants.separator).isActive = true
        self.separator.rightAnchor.constraint(equalTo:self.library.leftAnchor).isActive = true
        self.separator.widthAnchor.constraint(equalToConstant:Constants.border).isActive = true
    }
    
    @objc private func doCancel() {
        
    }
    
    @objc private func doCamera() {
        
    }
    
    @objc private func doLibrary() {
        
    }
}

private struct Constants {
    static let barHeight:CGFloat = 50.0
    static let buttonWidth:CGFloat = 80.0
    static let font:CGFloat = 12.0
    static let border:CGFloat = 1.0
    static let separator:CGFloat = 10.0
    static let camera:String = "Camera"
    static let library:String = "Library"
    static let cancel:String = "Cancel"
}
