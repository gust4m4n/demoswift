import UIKit

typealias UISegmentedControlValueChangedAction = (UISegmentedControl) -> ()

extension UISegmentedControl {
    static var key = "valueChangedAction"

    func setValueChanged(_ closure: @escaping UISegmentedControlValueChangedAction) {
        objc_setAssociatedObject(self, &UISegmentedControl.key, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        removeTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
        addTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
    }
    
    @objc func valueChangedAction() {
        let action: UISegmentedControlValueChangedAction? = objc_getAssociatedObject(self, &UISegmentedControl.key) as! UISegmentedControlValueChangedAction?
        action!(self)
    }
}

