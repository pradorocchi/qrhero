import UIKit
import AVFoundation

class Camera:UIView, AVCaptureMetadataOutputObjectsDelegate {
    private var session:AVCaptureSession?
    
    init() {
        super.init(frame:CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder:NSCoder) { return nil }
    
    func metadataOutput(_:AVCaptureMetadataOutput, didOutput objects:[AVMetadataObject], from:AVCaptureConnection) {
        guard
            let object:AVMetadataMachineReadableCodeObject = objects.first as? AVMetadataMachineReadableCodeObject,
            let string:String = object.stringValue
            else { return }
        self.cleanSession()
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//        self.presenter.read(string:string)
    }
    
    func startSession() {
        if self.session != nil { return }
        let session:AVCaptureSession = AVCaptureSession()
        session.sessionPreset = AVCaptureSession.Preset.hd1280x720
        let previewLayer:AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session:session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.frame = self.bounds
        self.session = session
        self.startInput()
        self.startOutput()
        self.layer.addSublayer(previewLayer)
        session.startRunning()
    }
    
    func cleanSession() {
        self.session?.stopRunning()
        self.session = nil
    }
    
    private func startInput() {
        let device:AVCaptureDevice?
        if #available(iOS 10.0, *) {
            device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for:AVMediaType.video,
                                             position:AVCaptureDevice.Position.back)
        } else { device = AVCaptureDevice.default(for:AVMediaType.video) }
        if let input:AVCaptureDevice = device {
            do { self.session?.addInput(try AVCaptureDeviceInput(device:input)) } catch { return }
        }
    }
    
    private func startOutput() {
        let output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
        self.session?.addOutput(output)
        if output.availableMetadataObjectTypes.contains(AVMetadataObject.ObjectType.qr) {
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        }
        output.setMetadataObjectsDelegate(self, queue:DispatchQueue.global(qos:DispatchQoS.QoSClass.background))
    }
}
