import UIKit

class DemoDrawerController : UIViewController {
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var labelFullname: UILabel!
    @IBOutlet weak var labelUsername: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
}

