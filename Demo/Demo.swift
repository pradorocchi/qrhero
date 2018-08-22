import UIKit

class Demo:UIViewController {
    weak var generate:UIButton!
    weak var scanner:UIButton!
    weak var text:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeOutlets()
        self.layoutOutlets()
    }
    
    private func makeOutlets() {
        let text:UITextField = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor(white:0.9, alpha:1.0)
        text.text = "Message here"
        self.text = text
        self.view.addSubview(text)
        
        let generate:UIButton = UIButton()
        generate.translatesAutoresizingMaskIntoConstraints = false
        generate.setTitle("Generate QR Code", for:UIControl.State())
        generate.setTitleColor(UIColor.blue, for:UIControl.State())
        generate.addTarget(self, action:#selector(self.doGenerate), for:UIControl.Event.touchUpInside)
        self.generate = generate
        self.view.addSubview(generate)
        
        let scanner:UIButton = UIButton()
        scanner.translatesAutoresizingMaskIntoConstraints = false
        scanner.setTitle("Scanner", for:UIControl.State())
        scanner.setTitleColor(UIColor.blue, for:UIControl.State())
        scanner.addTarget(self, action:#selector(self.doScanner), for:UIControl.Event.touchUpInside)
        self.scanner = scanner
        self.view.addSubview(scanner)
    }
    
    private func layoutOutlets() {
        self.text.topAnchor.constraint(equalTo:self.view.topAnchor, constant:80.0).isActive = true
        self.text.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        self.text.heightAnchor.constraint(equalToConstant:45.0).isActive = true
        self.text.widthAnchor.constraint(equalToConstant:220.0).isActive = true
        
        self.generate.topAnchor.constraint(equalTo:self.text.bottomAnchor, constant:20.0).isActive = true
        self.generate.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        self.generate.widthAnchor.constraint(equalToConstant:200.0).isActive = true
        self.generate.heightAnchor.constraint(equalToConstant:40.0).isActive = true
        
        self.scanner.topAnchor.constraint(equalTo:self.generate.bottomAnchor, constant:100.0).isActive = true
        self.scanner.centerXAnchor.constraint(equalTo:self.view.centerXAnchor).isActive = true
        self.scanner.widthAnchor.constraint(equalToConstant:200.0).isActive = true
        self.scanner.heightAnchor.constraint(equalToConstant:40.0).isActive = true
    }
    
    @objc private func doGenerate() {
        
    }
    
    @objc private func doScanner() {
        
    }
}
