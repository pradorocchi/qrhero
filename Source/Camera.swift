import UIKit
import AVFoundation

class Camera:UIView, AVCaptureMetadataOutputObjectsDelegate {
    weak var view:QRView!
    private var session:AVCaptureSession?
    
    init() {
        super.init(frame:CGRect.zero)
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
        }
    }
    
    func cleanSession() {
        session?.stopRunning()
        session = nil
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
        if output.availableMetadataObjectTypes.contains(.qr) {
            output.metadataObjectTypes = [.qr]
        }
        output.setMetadataObjectsDelegate(self, queue:.global(qos:.background))
        session?.addOutput(output)
    }
}
