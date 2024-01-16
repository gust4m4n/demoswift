import UIKit

extension UIView {
    static let UIViewImageTag = -12345678902

    func loadImage(url: String, placeholder: String = "", contentMode: UIView.ContentMode = .scaleAspectFill) {
        unloadImage()
        let iv = UIImageView()
        iv.tag = UIView.UIViewImageTag
        iv.contentMode = contentMode
        iv.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        iv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        iv.source(url: url, placeholder: placeholder)
        self.addSubview(iv)
    }
    
    func unloadImage() {
        for subview in self.subviews {
            if subview.tag == UIView.UIViewImageTag {
                subview.removeFromSuperview()
            }
        }
    }
}
