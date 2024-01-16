import UIKit

typealias UISwitchValueChangedAction = (UISwitch) -> ()

extension UISwitch {
    static var key = "valueChangedAction"

    func setValueChanged(_ closure: @escaping UISwitchValueChangedAction) {
        objc_setAssociatedObject(self, &UISwitch.key, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        removeTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
        addTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
    }
    
    @objc func valueChangedAction() {
        let action: UISwitchValueChangedAction? = objc_getAssociatedObject(self, &UISwitch.key) as! UISwitchValueChangedAction?
        action!(self)
    }
}

