import UIKit
import AVFoundation
import KSToastView

protocol DemoQRScanControllerDelegate {
    func QRScanDidSuccess(sender: DemoQRScanController, code: String)
}

class DemoQRScanController : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var preview: UIImageView!
    var delegate: DemoQRScanControllerDelegate?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var flashOn = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if TARGET_OS_SIMULATOR == 0 {
            captureSession = AVCaptureSession()
            let videoCaptureDevice = AVCaptureDevice.default(for: .video)
            let videoInput: AVCaptureDeviceInput
            
            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice!)
            } catch {
                return
            }
            
            captureSession.addInput(videoInput)
            let metadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            preview.layer.addSublayer(previewLayer)
            captureSession.startRunning()
        }
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if TARGET_OS_SIMULATOR == 0 {
            if (captureSession?.isRunning == false) {
                captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if TARGET_OS_SIMULATOR == 0 {
            if (captureSession?.isRunning == true) {
                captureSession.stopRunning()
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            captureSession.startRunning()
        }
    }
    
    func found(code: String) {
        DispatchQueue.main.async {
            self.delegate?.QRScanDidSuccess(sender: self, code: code)
            KSToastView.ks_showToast(code)
        }
    }
    
    @IBAction func btnFlashClicked(_ sender: UIButton?) {
        toggleFlash(on: !flashOn)
    }

    func toggleFlash(on: Bool) {
        if TARGET_OS_SIMULATOR == 0 {
            if let device = AVCaptureDevice.default(for: .video) {
                if device.hasTorch {
                    do {
                        try device.lockForConfiguration()
                        if on == true {
                            device.torchMode = .on
                            flashOn = true
                        } else {
                            device.torchMode = .off
                            flashOn = false
                        }
                        device.unlockForConfiguration()
                    } catch {
                    }
                } else {
                }
            }
        }
    }

    deinit {
    }
    
}
