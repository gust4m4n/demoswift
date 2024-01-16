import UIKit

extension UIView {
    static let UIViewLoadingTag = -12345678901

    func loading(on: Bool, backgroundColor: UIColor = UIColor.white, style: UIActivityIndicatorView.Style = .gray) -> Void {
        if on == true {
            for subview in self.subviews {
                if subview.tag == UIView.UIViewLoadingTag {
                    (subview as! UIActivityIndicatorView).stopAnimating()
                    subview.removeFromSuperview()
                }
            }
            let indicatorView = UIActivityIndicatorView(style: style)
            indicatorView.tag = UIView.UIViewLoadingTag
            indicatorView.backgroundColor = backgroundColor
            indicatorView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            indicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            indicatorView.startAnimating()
            self.addSubview(indicatorView)
        } else {
            for subview in self.subviews {
                if subview.tag == UIView.UIViewLoadingTag {
                    (subview as! UIActivityIndicatorView).stopAnimating()
                    subview.removeFromSuperview()
                }
            }
        }
    }
    
}
