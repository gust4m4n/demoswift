import UIKit
import MessageUI
import SwiftyJSON
import AVFoundation
import MobileCoreServices
import KSToastView
import ActionSheetPicker_3_0

class DemoController : UIViewController {
    @IBOutlet weak var btnMaterialShocase: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
                    
    @IBAction func btnPinClicked(_ sender: UIButton?) {
        let controller = DemoPinSheetController()
        controller.sheetShow(didCancel: {
        }, didConfirm: { (isBiometric, pin) in
        })
    }

    @IBAction func btnListViewClicked(_ sender: UIButton?) {
        let controller = DemoListViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnGridViewClicked(_ sender: UIButton?) {
        let controller = DemoGridViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnToastClicked(_ sender: UIButton?) {
        KSToastView.ks_showToast(NSLocalizedString("Hello world!", comment: ""))
    }

    @IBAction func btnCustomToastClicked(_ sender: UIButton?) {
        let controller = DemoCustomToastController()
        controller.toastShow(width: UIScreen.main.bounds.size.width, message: NSLocalizedString("No internet connection.", comment: ""), detail: NSLocalizedString("Please check your internet connection and try again.", comment: ""), btnCloseTitle: NSLocalizedString("Close", comment: ""), animated: true, btnCloseDidClicked: {
        }, didAutoClose: {
        });
    }

    @IBAction func btnBottomSheetClicked(_ sender: UIButton?) {
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "ic_demo_logo.png", message: LoremIpsumX.tiny(), detail: LoremIpsumX.medium(), btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: NSLocalizedString("Cancel", comment: ""), btnRightDidClicked: {
        }, didAutoClose: {
        });
    }

    @IBAction func btnDialogClicked(_ sender: UIButton?) {
        let controller = DemoDialogController()
        controller.popupShow(icon: "ic_demo_logo.png", message: LoremIpsumX.tiny(), detail: LoremIpsumX.medium(), btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: NSLocalizedString("Cancel", comment: ""), btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
        
    @IBAction func btnSnackBarClicked(_ sender: UIButton?) {
        let controller = DemoSnackMessageController()
        controller.sheetShow(message: NSLocalizedString("No internet connection.", comment: ""), detail: NSLocalizedString("Please check your internet connection and try again.", comment: ""), btnCloseTitle: NSLocalizedString("OK", comment: ""), btnCloseDidClicked: {
        }, didAutoClose: {
        });
    }

    @IBAction func btnQRCodeClicked(_ sender: UIButton?) {
        let controller = DemoQRCodeController()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnQRScanClicked(_ sender: UIButton?) {
        let controller = DemoQRScanController()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnDatePickerClicked(_ sender: UIButton?) {
        let picker = ActionSheetDatePicker(title: "", datePickerMode: .dateAndTime, selectedDate: Date(), doneBlock: {picker, value, index in
        }, cancel: { ActionStringCancelBlock in return }, origin: self.view)
        picker?.toolbarBackgroundColor = UINavigationBar.appearance().barTintColor
        picker?.toolbarButtonsColor = UINavigationBar.appearance().tintColor
        picker?.show()
    }

    @IBAction func btnCameraClicked(_ sender: UIButton?) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func btnGalleryClicked(_ sender: UIButton?) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func btnWebViewClicked(_ sender: UIButton?) {
        let controller = DemoWebViewController(notifTitle: "Swift.org", url: "https://www.swift.org/")
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnWebViewHtmlClicked(_ sender: UIButton?) {
        let controller = DemoHtmlController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
        
    @IBAction func btnHtmlLabelClicked(_ sender: UIButton?) {
        let controller = DemoHtmlLabelController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func btnBiometricClicked(_ sender: UIButton?) {
        CoreBiometric.request(completion: {succes in
            if succes == true {
            }
        })
    }
    
    @IBAction func btnXorClicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let key = "9b2611f319e2c88f1dce0a7a612bcf1f5b037bc66b9e8144725da7faf16cc3f2"
        let encrypted = plain.data().encryptXOR(key.data())
        let decrypted = encrypted.decryptXOR(key.data())
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "XOR", detail: "plain: \(plain)\nencrypted: \(encrypted.encodeHEX())\ndecrypted: \(decrypted.string())", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
    
    @IBAction func btnMd5Clicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let digest = plain.data().md5().encodeHEX()
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "MD5", detail: "plain: \(plain)\ndigest: \(digest)", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }

    @IBAction func btnShaClicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let digest = plain.data().sha().encodeHEX()
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "SHA", detail: "plain: \(plain)\ndigest: \(digest)", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
    
    @IBAction func btnDoubleEncryptClicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let encrypted = plain.data().encryptDouble()
        let decrypted = encrypted.decryptDouble()
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "DoubleEncrypt", detail: "plain: \(plain)\nencrypted: \(encrypted.encodeHEX())\ndecrypted: \(decrypted.string())", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
    
    @IBAction func btnBase64Clicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let encoded = plain.data().encodeBase64()
        let decoded = encoded.decodeBase64()
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "Base64", detail: "plain: \(plain)\nencoded: \(encoded)\ndecoded: \(decoded.string())", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
    
    @IBAction func btnAesClicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let key = "d3b91f0ebf75cc407114307b0ed67f3cd3b91f0ebf75cc407114307b0ed67f3c"
        let iv = "89e4ea9f678d2e94d9548043f54db492"        
        let encrypted = plain.data().encryptAES(key.decodeHEX(), iv.decodeHEX())
        let decrypted = encrypted.decryptAES(key.decodeHEX(), iv.decodeHEX())
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "AES", detail: "plain: \(plain)\nencrypted: \(encrypted.encodeHEX())\ndecrypted: \(decrypted.string())", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
    
    @IBAction func btnHexClicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let encoded = plain.data().encodeHEX()
        let decoded = encoded.decodeHEX()
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "HEX", detail: "plain: \(plain)\nencoded: \(encoded)\ndecoded: \(decoded.string())", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }

    // https://emn178.github.io/online-tools/crc32.html
    @IBAction func btnCrc32Clicked(_ sender: UIButton?) {
        let plain = LoremIpsumX.medium()
        let checksum = plain.data().crc()
        let controller = DemoBottomSheetController()
        controller.sheetShow(icon: "", message: "CRC", detail: "plain: \(plain)\nchecksum: \(checksum)", btnLeftTitle: NSLocalizedString("OK", comment: ""), btnLeftDidClicked: {
        }, btnRightTitle: "", btnRightDidClicked: {
        }, didAutoClose: {
        });
    }
        
    @IBAction func btnDrawerClicked(_ sender: UIButton?) {
        let controller = DemoDrawerController()
        controller.sheetShow(width: UIScreen.main.bounds.size.width * 0.8, direction: .right, didAutoClose: {
        })
    }

    @IBAction func btnDebitCardClicked(_ sender: UIButton?) {
        let controller = DemoDebitCardController()
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func btnShareTextClicked(_ sender: UIButton?) {
        let msg = "Welcome to the Swift community. Together we are working to build a programming language to empower everyone to turn their ideas into apps on any platform.\nhttps://www.swift.org/"
        let objects = [msg] as [Any]
        let controller = UIActivityViewController(activityItems: objects, applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func btnShareImageClicked(_ sender: UIButton?) {
        let image = UIImage(named: "ic_demo_logo.png")
        let objects = [image!] as [Any]
        let controller = UIActivityViewController(activityItems: objects, applicationActivities: nil)
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func btnCallClicked(_ sender: UIButton?) {
        UIApplication.callTo("+6200000000")
    }

    @IBAction func btnSmsClicked(_ sender: UIButton?) {
        UIApplication.smsTo("+6200000000")
    }
    
    @IBAction func btnNavigateClicked(_ sender: UIButton?) {
        UIApplication.navigateTo("https://www.swift.org/")
    }

    @IBAction func btnEmailClicked(_ sender: UIButton?) {
        UIApplication.emailTo("someone@example.com")
    }

    @IBAction func btnWhatsappClicked(_ sender: UIButton?) {
        UIApplication.whatsappTo("+6200000000")
    }

}

extension DemoController : UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let _ = info[.originalImage] as? UIImage {
            LoggerX.log("Photo picked!")
        }
        dismiss(animated: true, completion: nil)
    }
    
}
