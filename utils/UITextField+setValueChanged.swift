import UIKit

typealias UITextFieldValueChangedAction = (UITextField) -> ()

extension UITextField {
    static var key = "valueChangedAction"

    func setValueChanged(_ closure: @escaping UITextFieldValueChangedAction) {
        objc_setAssociatedObject(self, &UITextField.key, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        removeTarget(self, action: #selector(valueChangedAction), for: .editingChanged)
        addTarget(self, action: #selector(valueChangedAction), for: .editingChanged)
    }
    
    @objc func valueChangedAction() {
        let action: UITextFieldValueChangedAction? = objc_getAssociatedObject(self, &UITextField.key) as! UITextFieldValueChangedAction?
        action!(self)
    }
}

