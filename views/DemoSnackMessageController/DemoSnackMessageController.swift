import UIKit

class DemoSnackMessageController : UIViewController {
    @IBOutlet weak var bottomPaddingHeight: NSLayoutConstraint!
    @IBOutlet weak var labelMesasge: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    var message: String = "message"
    var detail: String = "detail"
    var btnCloseTitle: String = "btnLeft"
    var btnCloseDidClicked: (() -> Void)? = nil
    var didAutoClose: (() -> Void)? = nil

    func sheetShow(message: String, detail: String, btnCloseTitle: String, btnCloseDidClicked: @escaping () -> Void, didAutoClose: @escaping () -> Void) {
        self.message = message;
        self.detail = detail;
        self.btnCloseTitle = btnCloseTitle;
        self.btnCloseDidClicked = btnCloseDidClicked
        self.didAutoClose = didAutoClose
        sheetShow(width: UIScreen.main.bounds.size.width, height: 0.0, autoClose: true, didAutoClose:  {
            self.didAutoClose?()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottomPaddingHeight.constant = (window?.safeAreaInsets.bottom)!
        } else {
            bottomPaddingHeight.constant = 0.0
        }
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
    }
    
    @IBAction func btnLeftDidClicked(_ sender: UIButton?) {
        sheetClose {
            self.btnCloseDidClicked?()
        }
    }

    deinit {
    }

}
