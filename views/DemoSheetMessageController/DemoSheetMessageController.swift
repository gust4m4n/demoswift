import UIKit

class DemoSheetMessageController : UIViewController {
    @IBOutlet weak var bottomPaddingHeight: NSLayoutConstraint!
    @IBOutlet weak var svIcon: UIStackView!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var labelMesasge: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var svContent: UIStackView!
    var icon: String = ""
    var message: String = "message"
    var detail: String = "detail"
    var tag: Int = 0
    var btnLeftTitle: String = "btnLeft"
    var btnLeftDidClicked: (() -> Void)? = nil
    var btnRightTitle: String = "btnRight"
    var btnRightDidClicked: (() -> Void)? = nil
    var didAutoClose: (() -> Void)? = nil

    func sheetShow(icon: String, message: String, detail: String, tag: Int = 0, btnLeftTitle: String, btnLeftDidClicked: @escaping () -> Void, btnRightTitle: String, btnRightDidClicked: @escaping () -> Void, didAutoClose: @escaping () -> Void) {
        self.icon = icon
        self.message = message;
        self.detail = detail;
        self.tag = tag
        self.btnLeftTitle = btnLeftTitle;
        self.btnLeftDidClicked = btnLeftDidClicked
        self.btnRightTitle = btnRightTitle;
        self.btnRightDidClicked = btnRightDidClicked
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
        if (self.icon.count > 0) {
            self.ivIcon.source(url: self.icon)
            self.svIcon.isHidden = false;
        } else {
            self.svIcon.isHidden = true;
        }
        self.labelMesasge.text = self.message
        if self.message.count == 0 {
            self.labelMesasge.isHidden = true;
        }
        self.labelDetail.text = self.detail
        if self.detail.count == 0 {
            self.labelDetail.isHidden = true;
        }
        self.view.tag = self.tag
        self.btnLeft.setTitle(btnLeftTitle, for: .normal)
        if self.btnLeftTitle.count == 0 {
            self.btnLeft.isHidden = true;
        }
        self.btnRight.setTitle(btnRightTitle, for: .normal)
        if self.btnRightTitle.count == 0 {
            self.btnRight.isHidden = true;
        }
        
        let cxmax = UIScreen.main.bounds.width
        let size = self.svContent.systemLayoutSizeFitting(CGSize(width: cxmax, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        
        scrollViewHeight.constant = size.height
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.cornerRadiusTop(radius: 24.0)
    }

    @IBAction func btnCloseClicked(_ sender: UIButton?) {
        sheetClose {
            self.didAutoClose?()
        }
    }

    @IBAction func btnLeftDidClicked(_ sender: UIButton?) {
        sheetClose {
            self.btnLeftDidClicked?()
        }
    }

    @IBAction func btnRightDidClicked(_ sender: UIButton?) {
        sheetClose {
            self.btnRightDidClicked?()
        }
    }

    deinit {
    }

}
