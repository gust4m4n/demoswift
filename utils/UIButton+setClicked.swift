import UIKit

extension UIButton {
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        
        guard let color = color else {
            self.setBackgroundImage(nil, for: state)
            return
        }
        
        let length = 1 + cornerRadius * 2
        let size = CGSize(width: length, height: length)
        let rect = CGRect(origin: .zero, size: size)
        
        var backgroundImage = UIGraphicsImageRenderer(size: size).image { (context) in
            // Fill the square with the black color for later tinting.
            color.setFill()
            UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).fill()
        }
        
        backgroundImage = backgroundImage.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius))
        
        // Apply the `color` to the `backgroundImage` as a tint color
        // so that the `backgroundImage` can update its color automatically when the currently active traits are changed.
        if #available(iOS 13.0, *) {
            backgroundImage = backgroundImage.withTintColor(color, renderingMode: .alwaysOriginal)
        }
        
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    override open var backgroundColor: UIColor? {
        didSet {
            if let color = backgroundColor {
                setBackgroundColor(color.darker(0.25), for: .highlighted)
            }
        }
    }

    typealias UIButtonClickedAction = (UIButton) -> ()
    static var clickedActionKey = "clickedActionKey"
    
    func setClicked(_ closure: @escaping UIButtonClickedAction) {
        objc_setAssociatedObject(self, &UIButton.clickedActionKey, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        removeTarget(self, action: #selector(clickedAction), for: .touchUpInside)
        addTarget(self, action: #selector(clickedAction), for: .touchUpInside)
    }
    
    func setClickedNil() {
        removeTarget(self, action: #selector(clickedAction), for: .touchUpInside)
        objc_removeAssociatedObjects(self)
    }

    @objc func clickedAction() {
        let action: UIButtonClickedAction? = objc_getAssociatedObject(self, &UIButton.clickedActionKey) as! UIButtonClickedAction?
        action!(self)
    }
}

