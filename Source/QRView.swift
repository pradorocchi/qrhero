import UIKit

public class QRView:UIViewController {
    public weak var delegate:QRViewDelegate?
    private weak var camera:Camera!
    private weak var library:UIView!
    private weak var buttonCancel:UIButton!
    private weak var buttonCamera:UIButton!
    private weak var buttonLibrary:UIButton!
    private weak var border:UIView!
    private weak var separator:UIView!
    public override var prefersStatusBarHidden:Bool { get { return true } }
    public override var shouldAutorotate:Bool { get { return false } }
    public override var supportedInterfaceOrientations:UIInterfaceOrientationMask { get {
        return UIInterfaceOrientationMask.portrait } }
    
    public init() {
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder) { return nil }
    
    @objc func doCancel() {
        self.camera.cleanSession()
        self.delegate?.qrCancelled()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.makeOutlets()
        self.layuoutOutlets()
    }
    
    public override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        self.doCamera()
    }
    
    private func makeOutlets() {
        let camera:Camera = Camera()
        self.camera = camera
        self.view.addSubview(camera)
        
        let library:UIView = UIView()
        library.isUserInteractionEnabled = false
        library.translatesAutoresizingMaskIntoConstraints = false
        self.library = library
        self.view.addSubview(library)
        
        let buttonCancel:UIButton = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(UIColor.white, for:UIControl.State.normal)
        buttonCancel.setTitleColor(UIColor(white:1.0, alpha:0.4), for:UIControl.State.selected)
        buttonCancel.setTitleColor(UIColor(white:1.0, alpha:0.4), for:UIControl.State.highlighted)
        buttonCancel.setTitle(Constants.cancel, for:UIControl.State())
        buttonCancel.titleLabel!.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.light)
        buttonCancel.addTarget(self, action:#selector(self.doCancel), for:UIControl.Event.touchUpInside)
        self.buttonCancel = buttonCancel
        self.view.addSubview(buttonCancel)
        
        let buttonCamera:UIButton = UIButton()
        buttonCamera.translatesAutoresizingMaskIntoConstraints = false
        buttonCamera.setTitleColor(UIColor(white:1.0, alpha:0.4), for:UIControl.State.normal)
        buttonCamera.setTitleColor(UIColor.white, for:UIControl.State.selected)
        buttonCamera.setTitleColor(UIColor.white, for:UIControl.State.highlighted)
        buttonCamera.setTitle(Constants.camera, for:UIControl.State())
        buttonCamera.titleLabel!.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.bold)
        buttonCamera.addTarget(self, action:#selector(self.doCamera), for:UIControl.Event.touchUpInside)
        self.buttonCamera = buttonCamera
        self.view.addSubview(buttonCamera)
        
        let buttonLibrary:UIButton = UIButton()
        buttonLibrary.translatesAutoresizingMaskIntoConstraints = false
        buttonLibrary.setTitleColor(UIColor(white:1.0, alpha:0.4), for:UIControl.State.normal)
        buttonLibrary.setTitleColor(UIColor.white, for:UIControl.State.selected)
        buttonLibrary.setTitleColor(UIColor.white, for:UIControl.State.highlighted)
        buttonLibrary.setTitle(Constants.library, for:UIControl.State())
        buttonLibrary.titleLabel!.font = UIFont.systemFont(ofSize:Constants.font, weight:UIFont.Weight.bold)
        buttonLibrary.addTarget(self, action:#selector(self.doLibrary), for:UIControl.Event.touchUpInside)
        self.buttonLibrary = buttonLibrary
        self.view.addSubview(buttonLibrary)
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = UIColor.white
        self.border = border
        self.view.addSubview(border)
        
        let separator:UIView = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.isUserInteractionEnabled = false
        separator.backgroundColor = UIColor(white:1.0, alpha:0.3)
        self.separator = separator
        self.view.addSubview(separator)
    }
    
    private func layuoutOutlets() {
        self.camera.topAnchor.constraint(equalTo:self.border.bottomAnchor).isActive = true
        self.camera.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
        self.camera.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.camera.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
        
        self.library.topAnchor.constraint(equalTo:self.border.bottomAnchor).isActive = true
        self.library.bottomAnchor.constraint(equalTo:self.view.bottomAnchor).isActive = true
        self.library.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.library.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
        
        self.buttonCancel.bottomAnchor.constraint(equalTo:self.border.topAnchor).isActive = true
        self.buttonCancel.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.buttonCancel.widthAnchor.constraint(equalToConstant:Constants.buttonWidth).isActive = true
        
        self.buttonLibrary.bottomAnchor.constraint(equalTo:self.border.topAnchor).isActive = true
        self.buttonLibrary.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
        self.buttonLibrary.widthAnchor.constraint(equalToConstant:Constants.buttonWidth).isActive = true
        
        self.buttonCamera.bottomAnchor.constraint(equalTo:self.border.topAnchor).isActive = true
        self.buttonCamera.rightAnchor.constraint(equalTo:self.separator.leftAnchor).isActive = true
        self.buttonCamera.widthAnchor.constraint(equalToConstant:Constants.buttonWidth).isActive = true
        
        self.border.leftAnchor.constraint(equalTo:self.view.leftAnchor).isActive = true
        self.border.rightAnchor.constraint(equalTo:self.view.rightAnchor).isActive = true
        self.border.heightAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        self.separator.bottomAnchor.constraint(equalTo:self.border.topAnchor,
                                            constant:-Constants.separator).isActive = true
        self.separator.rightAnchor.constraint(equalTo:self.buttonLibrary.leftAnchor).isActive = true
        self.separator.widthAnchor.constraint(equalToConstant:Constants.border).isActive = true
        
        if #available(iOS 11.0, *) {
            self.buttonCancel.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.buttonLibrary.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.buttonCamera.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            self.border.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor,
                                             constant:Constants.barHeight).isActive = true
            self.separator.topAnchor.constraint(equalTo:self.view.safeAreaLayoutGuide.topAnchor,
                                                constant:Constants.separator).isActive = true
        } else {
            self.buttonCancel.topAnchor.constraint(equalTo:self.view.topAnchor).isActive = true
            self.buttonLibrary.topAnchor.constraint(equalTo:self.view.topAnchor).isActive = true
            self.buttonCamera.topAnchor.constraint(equalTo:self.view.topAnchor).isActive = true
            self.border.topAnchor.constraint(equalTo:self.view.topAnchor, constant:Constants.barHeight).isActive = true
            self.separator.topAnchor.constraint(equalTo:self.view.topAnchor,
                                                constant:Constants.separator).isActive = true
        }
    }
    
    @objc private func doCamera() {
        self.buttonCamera.isSelected = true
        self.buttonLibrary.isSelected = false
        self.camera.isHidden = false
        self.library.isHidden = true
        self.camera.startSession()
    }
    
    @objc private func doLibrary() {
        self.buttonCamera.isSelected = false
        self.buttonLibrary.isSelected = true
        self.camera.isHidden = true
        self.library.isHidden = false
        self.camera.cleanSession()
    }
}

private struct Constants {
    static let barHeight:CGFloat = 38.0
    static let buttonWidth:CGFloat = 64.0
    static let font:CGFloat = 12.0
    static let border:CGFloat = 1.0
    static let separator:CGFloat = 10.0
    static let camera:String = "Camera"
    static let library:String = "Library"
    static let cancel:String = "Cancel"
}
