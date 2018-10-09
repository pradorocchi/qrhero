import UIKit
import QRhero

class Demo:UIViewController, QRViewDelegate {
    private weak var generate:UIButton!
    private weak var scanner:UIButton!
    private weak var text:UITextField!
    private let hero = Hero()
    
    func qrRead(content:String) {
        dismiss(animated:true) { [weak self] in
            let alert = UIAlertController(title:"Read", message:content, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title:"Continue", style:.default, handler:nil))
            self?.present(alert, animated:true)
        }
    }
    
    func qrError(error:HeroError) {
        dismiss(animated:true) { [weak self] in
            let alert = UIAlertController(title:"Read", message:error.localizedDescription, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title:"Continue", style:.default, handler:nil))
            self?.present(alert, animated:true)
        }
    }
    
    func qrCancelled() {
        dismiss(animated:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeOutlets()
        layoutOutlets()
    }
    
    private func makeOutlets() {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = UIColor(white:0.9, alpha:1)
        text.text = "Message here"
        view.addSubview(text)
        self.text = text
        
        let generate = UIButton()
        generate.translatesAutoresizingMaskIntoConstraints = false
        generate.setTitle("Generate QR Code", for:[])
        generate.setTitleColor(.blue, for:[])
        generate.addTarget(self, action:#selector(doGenerate), for:.touchUpInside)
        view.addSubview(generate)
        self.generate = generate
        
        let scanner = UIButton()
        scanner.translatesAutoresizingMaskIntoConstraints = false
        scanner.setTitle("Scanner", for:[])
        scanner.setTitleColor(.blue, for:[])
        scanner.addTarget(self, action:#selector(doScanner), for:.touchUpInside)
        view.addSubview(scanner)
        self.scanner = scanner
    }
    
    private func layoutOutlets() {
        text.topAnchor.constraint(equalTo:view.topAnchor, constant:80).isActive = true
        text.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        text.heightAnchor.constraint(equalToConstant:45).isActive = true
        text.widthAnchor.constraint(equalToConstant:220).isActive = true
        
        generate.topAnchor.constraint(equalTo:text.bottomAnchor, constant:20).isActive = true
        generate.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        generate.widthAnchor.constraint(equalToConstant:200).isActive = true
        generate.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        scanner.topAnchor.constraint(equalTo:generate.bottomAnchor, constant:100).isActive = true
        scanner.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        scanner.widthAnchor.constraint(equalToConstant:200).isActive = true
        scanner.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    
    @objc private func doGenerate() {
        hero.write(content:text.text!) { [weak self] image in
            self?.share(image:image)
        }
    }
    
    @objc private func doScanner() {
        let view = QRView()
        view.title = "QR Codes"
        view.delegate = self
        present(view, animated:true)
    }
    
    private func share(image:UIImage) {
        let activity = UIActivityViewController(activityItems:[image], applicationActivities:nil)
        if let popover = activity.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = .zero
            popover.permittedArrowDirections = .any
        }
        present(activity, animated:true)
    }
}
