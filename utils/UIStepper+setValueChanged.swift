import UIKit

typealias UIStepperValueChangedAction = (UIStepper) -> ()

extension UIStepper {
    static var key = "valueChangedAction"

    func setValueChanged(_ closure: @escaping UIStepperValueChangedAction) {
        objc_setAssociatedObject(self, &UIStepper.key, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        removeTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
        addTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
    }
    
    @objc func valueChangedAction() {
        let action: UIStepperValueChangedAction? = objc_getAssociatedObject(self, &UIStepper.key) as! UIStepperValueChangedAction?
        action!(self)
    }
}

