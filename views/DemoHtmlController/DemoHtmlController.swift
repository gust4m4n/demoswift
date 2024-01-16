import UIKit
import WebKit

class DemoHtmlController : UIViewController {
    @IBOutlet weak var wkWebView: WKWebView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.isOpaque = false
        self.wkWebView.backgroundColor = .white
        self.wkWebView.contentMode = .scaleAspectFit
        self.wkWebView.navigationDelegate = self
        self.wkWebView?.loadHtmlBody(LoremIpsumX.big().replacingOccurrences(of: "\n", with: "<br>"), marginLeft: 16.0, marginTop: 16.0, marginRight: 16.0, marginBottom: 16.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
        
    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }

    deinit {
    }
}

extension DemoHtmlController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (value, error) in
                    if let height = value as? CGFloat {
                        LoggerX.log("Content height: \(height)")
                    }
                })
            }
        })
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        if(navigationAction.navigationType == .other) {
            if let url = navigationAction.request.url {
                if url.absoluteString.hasPrefix("https://deeplink") == true {
                    let _ = navigationAction.request.url!.parseQueryString
                    decisionHandler(.cancel)
                    return
                }
            }
        }
        decisionHandler(.allow)
    }
}

