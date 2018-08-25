import UIKit

public class QRView:UIViewController {
    public weak var delegate:QRViewDelegate?
    private weak var camera:Camera!
    private weak var library:Library!
    private weak var buttonCancel:UIButton!
    private weak var buttonCamera:UIButton!
    private weak var buttonLibrary:UIButton!
    private weak var border:UIView!
    private weak var separator:UIView!
    private weak var label:UILabel!
    private let qrHero:QRhero
    public override var prefersStatusBarHidden:Bool { return true }
    public override var shouldAutorotate:Bool { return false }
    public override var supportedInterfaceOrientations:UIInterfaceOrientationMask { return .portrait }
    public override var title:String? { didSet { label?.text = title } }
    private static let barHeight:CGFloat = 38
    private static let buttonWidth:CGFloat = 58
    private static let font:CGFloat = 12
    private static let border:CGFloat = 1
    private static let separator:CGFloat = 10
    private static let camera = "Camera"
    private static let library = "Library"
    private static let cancel = "Cancel"
    
    public init() {
        self.qrHero = QRhero()
        super.init(nibName:nil, bundle:nil)
    }
    
    public required init?(coder:NSCoder) { return nil }
    
    @objc func doCancel() {
        camera.cleanSession()
        delegate?.qrCancelled()
    }
    
    func read(image:UIImage) {
        self.qrHero.read(image:image, result: { [weak self] (content) in
            self?.read(content:content)
        } ) { [weak self] (error) in
            self?.delegate?.qrError(error:error)
        }
    }
    
    func read(content:String) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.qrRead(content:content)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        makeOutlets()
        layuoutOutlets()
    }
    
    public override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        doCamera()
    }
    
    public override func viewWillDisappear(_ animated:Bool) {
        super.viewWillDisappear(animated)
        camera.cleanSession()
    }
    
    private func makeOutlets() {
        let camera = Camera()
        camera.view = self
        view.addSubview(camera)
        self.camera = camera
        
        let library = Library()
        library.view = self
        view.addSubview(library)
        self.library = library
        
        let buttonCancel = UIButton()
        buttonCancel.translatesAutoresizingMaskIntoConstraints = false
        buttonCancel.setTitleColor(.white, for:.normal)
        buttonCancel.setTitleColor(UIColor(white:1, alpha:0.4), for:.selected)
        buttonCancel.setTitleColor(UIColor(white:1, alpha:0.4), for:.highlighted)
        buttonCancel.setTitle(QRView.cancel, for:[])
        buttonCancel.titleLabel!.font = UIFont.systemFont(ofSize:QRView.font, weight:.regular)
        buttonCancel.addTarget(self, action:#selector(doCancel), for:.touchUpInside)
        view.addSubview(buttonCancel)
        self.buttonCancel = buttonCancel
        
        let buttonCamera:UIButton = UIButton()
        buttonCamera.translatesAutoresizingMaskIntoConstraints = false
        buttonCamera.setTitleColor(UIColor(white:1, alpha:0.4), for:.normal)
        buttonCamera.setTitleColor(.white, for:.selected)
        buttonCamera.setTitleColor(.white, for:.highlighted)
        buttonCamera.setTitle(QRView.camera, for:[])
        buttonCamera.titleLabel!.font = UIFont.systemFont(ofSize:QRView.font, weight:.bold)
        buttonCamera.addTarget(self, action:#selector(doCamera), for:.touchUpInside)
        view.addSubview(buttonCamera)
        self.buttonCamera = buttonCamera
        
        let buttonLibrary:UIButton = UIButton()
        buttonLibrary.translatesAutoresizingMaskIntoConstraints = false
        buttonLibrary.setTitleColor(UIColor(white:1, alpha:0.4), for:.normal)
        buttonLibrary.setTitleColor(.white, for:.selected)
        buttonLibrary.setTitleColor(.white, for:.highlighted)
        buttonLibrary.setTitle(QRView.library, for:[])
        buttonLibrary.titleLabel!.font = UIFont.systemFont(ofSize:QRView.font, weight:.bold)
        buttonLibrary.addTarget(self, action:#selector(doLibrary), for:.touchUpInside)
        view.addSubview(buttonLibrary)
        self.buttonLibrary = buttonLibrary
        
        let border:UIView = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.isUserInteractionEnabled = false
        border.backgroundColor = .white
        view.addSubview(border)
        self.border = border
        
        let separator:UIView = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.isUserInteractionEnabled = false
        separator.backgroundColor = UIColor(white:1, alpha:0.3)
        view.addSubview(separator)
        self.separator = separator
        
        let label:UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.textColor = .white
        label.isUserInteractionEnabled = false
        label.font = UIFont.systemFont(ofSize:QRView.font, weight:.light)
        label.text = title
        view.addSubview(label)
        self.label = label
    }
    
    private func layuoutOutlets() {
        camera.topAnchor.constraint(equalTo:border.bottomAnchor).isActive = true
        camera.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        camera.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        camera.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        library.topAnchor.constraint(equalTo:border.bottomAnchor).isActive = true
        library.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        library.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        library.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        buttonCancel.bottomAnchor.constraint(equalTo:border.topAnchor).isActive = true
        buttonCancel.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        buttonCancel.widthAnchor.constraint(equalToConstant:QRView.buttonWidth).isActive = true
        
        buttonLibrary.bottomAnchor.constraint(equalTo:border.topAnchor).isActive = true
        buttonLibrary.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        buttonLibrary.widthAnchor.constraint(equalToConstant:QRView.buttonWidth).isActive = true
        
        buttonCamera.bottomAnchor.constraint(equalTo:border.topAnchor).isActive = true
        buttonCamera.rightAnchor.constraint(equalTo:separator.leftAnchor).isActive = true
        buttonCamera.widthAnchor.constraint(equalToConstant:QRView.buttonWidth).isActive = true
        
        border.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        border.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant:QRView.border).isActive = true
        
        separator.bottomAnchor.constraint(equalTo:border.topAnchor, constant:-QRView.separator).isActive = true
        separator.rightAnchor.constraint(equalTo:buttonLibrary.leftAnchor).isActive = true
        separator.widthAnchor.constraint(equalToConstant:QRView.border).isActive = true
        
        label.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo:border.topAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            buttonCancel.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            buttonLibrary.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            buttonCamera.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            border.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,
                                        constant:QRView.barHeight).isActive = true
            separator.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor,
                                           constant:QRView.separator).isActive = true
            label.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            buttonCancel.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            buttonLibrary.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            buttonCamera.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            border.topAnchor.constraint(equalTo:view.topAnchor, constant:QRView.barHeight).isActive = true
            separator.topAnchor.constraint(equalTo:view.topAnchor, constant:QRView.separator).isActive = true
            label.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        }
    }
    
    @objc private func doCamera() {
        buttonCamera.isSelected = true
        buttonLibrary.isSelected = false
        camera.isHidden = false
        library.isHidden = true
        camera.startSession()
    }
    
    @objc private func doLibrary() {
        buttonCamera.isSelected = false
        buttonLibrary.isSelected = true
        camera.isHidden = true
        library.isHidden = false
        camera.cleanSession()
        library.startLoading()
    }
}
