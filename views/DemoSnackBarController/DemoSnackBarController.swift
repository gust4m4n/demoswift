import UIKit

enum DemoSnackBarColor {
    case success
    case error
    case warning
    case info
}

struct DemoSnackBar {

    static func showSuccess(msg: String) {
        if msg.count > 0 {
            let controller = DemoSnackBarController(msg: msg.substring(length: 1024), color: .success)
            controller.showSnackBar()
        }
    }

    static func showError(msg: String) {
        if msg.count > 0 {
            if msg == "Tidak ada koneksi internet." || msg == "Koneksi tidak stabil, silahkan ulangi kembali." {
                let controller = DemoSnackBarController(msg: msg.substring(length: 1024), color: .warning)
                controller.showSnackBar()
            } else {
                let controller = DemoSnackBarController(msg: msg.substring(length: 1024), color: .error)
                controller.showSnackBar()
            }
        }
    }

    static func showWarning(msg: String) {
        if msg.count > 0 {
            let controller = DemoSnackBarController(msg: msg.substring(length: 1024), color: .warning)
            controller.showSnackBar()
        }
    }
    
    static func showInfo(msg: String) {
        if msg.count > 0 {
            let controller = DemoSnackBarController(msg: msg.substring(length: 1024), color: .info)
            controller.showSnackBar()
        }
    }
    
    static func showBottomSuccess(msg: String) {
        if msg.count > 0 {
            let controller = DemoSnackBarController(msg: msg.substring(length: 1024), color: .success)
            controller.showSnackBar(position: .bottom)
        }
    }


}

class DemoSnackBarController : UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var labelMsg: UILabel!
    var msg: String = ""
    var color: DemoSnackBarColor = .success
    
    convenience init (msg: String, color: DemoSnackBarColor) {
        self.init()
        self.msg = msg
        self.color = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = false
        if self.color == .success {
            self.container.backgroundColor = UIColor(hex: 0x01B14E).withAlphaComponent(0.8)
        } else
        if self.color == .error {
            self.container.backgroundColor = UIColor(hex: 0xF83419).withAlphaComponent(0.8)
        } else
        if self.color == .warning {
            self.container.backgroundColor = UIColor(hex: 0xF8C719).withAlphaComponent(0.8)
        } else
        if self.color == .info {
            self.container.backgroundColor = UIColor(hex: 0x0C80EF).withAlphaComponent(0.8)
        }
        self.labelMsg.text = self.msg
    }
    
    deinit {
    }
}
