import UIKit
import WebKit

class DemoWebViewController : UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var notifTitle = ""
    var url = ""

    convenience init (notifTitle: String, url: String) {
        self.init()
        self.notifTitle = notifTitle
        self.url = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelTitle.text = self.notifTitle
        self.webView.scrollView.bounces = false
        self.webView.scrollView.bouncesZoom = false
        self.webView?.navigationDelegate = self
        if let theUrl = URL(string: self.url) {
            self.webView?.load(URLRequest(url: theUrl))
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DemoWebViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        decisionHandler(.allow)
    }
}

