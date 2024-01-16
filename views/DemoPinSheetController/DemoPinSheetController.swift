import UIKit

class DemoPinSheetController : UIViewController {
    @IBOutlet weak var pin1: UIView!
    @IBOutlet weak var pin2: UIView!
    @IBOutlet weak var pin3: UIView!
    @IBOutlet weak var pin4: UIView!
    @IBOutlet weak var pin5: UIView!
    @IBOutlet weak var pin6: UIView!
    var pin: String = ""
    var didCancelHandler: (() -> Void)? = nil
    var didConfirmHandler: ((_ isBiometric: Bool, _ pin: String) -> Void)? = nil
    
    func sheetShow(didCancel: (() -> Void)? = nil, didConfirm: ((_ isBiometric: Bool, _ pin: String) -> Void)? = nil) {
        didCancelHandler = didCancel
        didConfirmHandler = didConfirm
        sheetShow(width: UIScreen.main.bounds.size.width, height: 0.0, keyboardAvoiding: false, animated: true, didPushed: {
        }, didAutoClose: {
            self.didCancelHandler?()
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .white
        showDots()
        self.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.cornerRadiusTop(radius: 24.0)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    @IBAction func btnNumberClicked(sender: UIButton?) {
        if pin.count < 6  {
            pin = pin + "\(String(sender!.tag))"
        }
        showDots()
        if pin.count >= 6 {
            sheetClose(didPop: {
                self.didConfirmHandler?(false, self.pin)
                self.pin = ""
            })
        }
    }
    
    func showDots() {
        let labels = [pin1, pin2, pin3, pin4, pin5, pin6]
        for item in labels {
            item?.backgroundColor = UIColor(hex: 0xEBEBEB)
        }
        for i in 0 ..< pin.count {
            labels[i]?.backgroundColor = UIColor(hex: 0x343434)
        }
    }
    
    @IBAction func btnCancelClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnBackspaceClicked(_ sender: UIButton?) {
        if pin.count > 0 {
            pin.removeLast(1)
            showDots()
        }
    }
        
    @IBAction func btnSheetBackClicked(_ sender: UIButton?) {
        sheetClose(didPop: {
            self.didCancelHandler?()
            self.pin = ""
        })
    }

    @IBAction func btnSheetCloseClicked(_ sender: UIButton?) {
        sheetClose(didPop: {
            self.didCancelHandler?()
            self.pin = ""
        })
    }
        
}

