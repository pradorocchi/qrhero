import UIKit
import AVFoundation

class Camera:UIView, AVCaptureMetadataOutputObjectsDelegate {
    weak var view:QRView!
    private weak var finder:UIView?
    private var session:AVCaptureSession?
    private static let border:CGFloat = 1
    private static let finder:CGFloat = 250
    
    init() {
        super.init(frame:.zero)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func metadataOutput(_:AVCaptureMetadataOutput, didOutput objects:[AVMetadataObject], from:AVCaptureConnection) {
        guard
            let object = objects.first as? AVMetadataMachineReadableCodeObject,
            let string = object.stringValue
        else { return }
        cleanSession()
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        view.read(content:string)
    }
    
    func startSession() {
        if session == nil {
            let session = AVCaptureSession()
            session.sessionPreset = .hd1280x720
            let preview = AVCaptureVideoPreviewLayer(session:session)
            preview.videoGravity = .resizeAspectFill
            preview.frame = bounds
            self.session = session
            startInput()
            startOutput()
            layer.addSublayer(preview)
            session.startRunning()
            makeOutlets()
        }
    }
    
    func cleanSession() {
        session?.stopRunning()
        session = nil
        DispatchQueue.main.async { [weak self] in self?.finder?.removeFromSuperview()  }
    }
    
    private func makeOutlets() {
        let finder = UIView()
        finder.isUserInteractionEnabled = false
        finder.translatesAutoresizingMaskIntoConstraints = false
        finder.layer.borderWidth = Camera.border
        finder.layer.borderColor = UIColor.white.cgColor
        addSubview(finder)
        finder.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        finder.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        finder.widthAnchor.constraint(equalToConstant:Camera.finder).isActive = true
        finder.heightAnchor.constraint(equalToConstant:Camera.finder).isActive = true
        self.finder = finder
    }
    
    private func startInput() {
        let device:AVCaptureDevice?
        if #available(iOS 10.0, *) {
            device = AVCaptureDevice.default(.builtInWideAngleCamera, for:.video, position:.back)
        } else { device = AVCaptureDevice.default(for:.video) }
        if let input = device {
            do { session?.addInput(try AVCaptureDeviceInput(device:input)) } catch { return }
        }
    }
    
    private func startOutput() {
        let output = AVCaptureMetadataOutput()
        session?.addOutput(output)
        if output.availableMetadataObjectTypes.contains(.qr) {
            output.metadataObjectTypes = [.qr]
        }
        output.setMetadataObjectsDelegate(self, queue:.global(qos:.background))
    }
}
