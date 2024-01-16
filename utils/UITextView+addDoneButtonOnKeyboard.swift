import UIKit

extension UITextView{
    static var textViewDoneButtonAction = "textViewDoneButtonAction"

    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard(barColor: UIColor? = UINavigationBar.appearance().barTintColor ?? .white, textColor: UIColor? = UINavigationBar.appearance().tintColor ?? UIColor.black, doneButtonAction: (() -> Void)? = nil) {
        
        objc_setAssociatedObject(self, &UITextView.textViewDoneButtonAction, doneButtonAction, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50.0))
        doneToolbar.isTranslucent = true
        doneToolbar.barStyle = UINavigationBar.appearance().barStyle
        doneToolbar.barTintColor = barColor
        doneToolbar.tintColor = UINavigationBar.appearance().tintColor
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(self.doneButtonAction))
        var doneButtonAttr = UIBarButtonItem.appearance().titleTextAttributes(for: UIControl.State.normal)
        doneButtonAttr?[NSAttributedString.Key.foregroundColor] = textColor ?? UIColor.black
        done.setTitleTextAttributes(doneButtonAttr, for: UIControl.State.normal)
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        if let doneButtonAction = objc_getAssociatedObject(self, &UITextView.textViewDoneButtonAction) as! (() -> Void)? {
            doneButtonAction()
        }
    }
}

