import UIKit

class DemoDialogController : UIViewController {
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var labelMesasge: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var svContent: UIStackView!
    var icon: String = "ic_demo_logo.png"
    var message: String = "message"
    var detail: String = "detail"
    var btnLeftTitle: String = "btnLeft"
    var btnLeftDidClicked: (() -> Void)? = nil
    var btnRightTitle: String = "btnRight"
    var btnRightDidClicked: (() -> Void)? = nil
    var didAutoClose: (() -> Void)? = nil

    func popupShow(icon: String, message: String, detail: String, btnLeftTitle: String, btnLeftDidClicked: @escaping () -> Void, btnRightTitle: String, btnRightDidClicked: @escaping () -> Void, didAutoClose: @escaping () -> Void) {
        self.icon = icon
        self.message = message;
        self.detail = detail;
        self.btnLeftTitle = btnLeftTitle;
        self.btnLeftDidClicked = btnLeftDidClicked
        self.btnRightTitle = btnRightTitle;
        self.btnRightDidClicked = btnRightDidClicked
        self.didAutoClose = didAutoClose
        self.popupShow(animated: true, didShow: {
        }, didAutoClose: {
            self.didAutoClose?()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.icon.count > 0) {
            self.ivIcon.source(url: self.icon)
        } else {
            self.ivIcon.isHidden = true;
        }
        self.labelMesasge.text = self.message
        if self.message.count == 0 {
            self.labelMesasge.isHidden = true;
        }
        self.labelDetail.text = self.detail
        if self.detail.count == 0 {
            self.labelDetail.isHidden = true;
        }
        self.btnLeft.setTitle(btnLeftTitle, for: .normal)
        if self.btnLeftTitle.count == 0 {
            self.btnLeft.isHidden = true;
        }
        self.btnRight.setTitle(btnRightTitle, for: .normal)
        if self.btnRightTitle.count == 0 {
            self.btnRight.isHidden = true;
        }
        
        let cxmax = UIScreen.main.bounds.width * 0.85
        let size = self.svContent.systemLayoutSizeFitting(CGSize(width: cxmax, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        
        scrollViewHeight.constant = size.height

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    @IBAction func btnLeftDidClicked(_ sender: UIButton?) {
        popupClose {
            self.btnLeftDidClicked?()
        }
    }

    @IBAction func btnRightDidClicked(_ sender: UIButton?) {
        popupClose {
            self.btnRightDidClicked?()
        }
    }

    deinit {
    }

}
