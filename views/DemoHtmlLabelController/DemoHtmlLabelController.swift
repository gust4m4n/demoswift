import UIKit
import SwiftyJSON
import Atributika
import KSToastView

class DemoHtmlLabelController : UIViewController {
    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let htmlLabel = AttributedLabel()
        htmlLabel.numberOfLines = 0
        htmlLabel.lineBreakMode = .byWordWrapping
        let normalFont = UIFont(name: "Roboto-Regular", size: 15.0)!
        let boldFont = UIFont(name: "Roboto-Bold", size: 15.0)!
        let normalColor = UIColor(hex: 0x343434)
        let linkColor = UIColor(hex: 0x007BFF)
        let styleAll = Style.font(normalFont)
        let styleBold = Style("b")
            .font(boldFont)
            .foregroundColor(normalColor, .normal)
        let styleUnderline = Style("u").underlineStyle(.single)
        let styleLink = Style("a")
            .foregroundColor(linkColor, .normal)
            .foregroundColor(normalColor, .highlighted)
        
        htmlLabel.attributedText = "By signing up you confirm that you have read and agree to our company <a href=\"privacy_policy\"><u>Privacy Policy</u></a> & <a href=\"tnc\"><u>Terms and Conditions</u></a>"
            .style(tags: styleLink, styleBold, styleUnderline)
            .styleAll(styleAll)
        
        htmlLabel.onClick = { label, detection in
            switch detection.type {
            case .tag(let tag):
                if tag.name == "a", let href = tag.attributes["href"], let url = URL(string: href) {
                    KSToastView.ks_showToast(url)
                }
            default:
                break
            }
        }

        self.stackView.addArrangedSubview(htmlLabel)

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

