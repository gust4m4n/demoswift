import UIKit

class DemoCustomToastController : UIViewController {
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var labelMesasge: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    var message: String = "message"
    var detail: String = "detail"
    var btnCloseTitle: String = "close"
    var btnCloseDidClicked: (() -> Void)? = nil
    var didAutoClose: (() -> Void)? = nil

    func toastShow(width: CGFloat = 0.0, message: String, detail: String, btnCloseTitle: String, animated: Bool = true, btnCloseDidClicked: @escaping () -> Void, didAutoClose: @escaping () -> Void) {
        self.message = message;
        self.detail = detail;
        self.btnCloseTitle = btnCloseTitle;
        self.btnCloseDidClicked = btnCloseDidClicked
        self.didAutoClose = didAutoClose
        
        toastShow(width: width, animated: animated, didAutoClose: {
            self.didAutoClose?()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelMesasge.text = self.message
        if self.message.count == 0 {
            self.labelMesasge.isHidden = true;
        }
        self.labelDetail.text = self.detail
        if self.detail.count == 0 {
            self.labelDetail.isHidden = true;
        }
        self.btnClose.setTitle(btnCloseTitle, for: .normal)
        if self.btnCloseTitle.count == 0 {
            self.btnClose.isHidden = true;
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.container.cornerRadius = 8.0
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton?) {
        toastClose(didClose: {
            self.btnCloseDidClicked?()
        })
    }

    deinit {
    }

}
