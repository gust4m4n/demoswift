import UIKit

class DemoQRCodeController : UIViewController {
    @IBOutlet weak var ivQR: UIImageView!
    @IBOutlet weak var labelValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ivQR.image = UIImage.generateQR(code: self.labelValue.text!, width: self.ivQR.frame.size.width, height: self.ivQR.frame.size.height)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }

}
