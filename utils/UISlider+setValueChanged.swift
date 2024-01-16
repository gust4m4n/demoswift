import UIKit

typealias UISliderValueChangedAction = (UISlider) -> ()

extension UISlider {
    static var key = "valueChangedAction"

    func setValueChanged(_ closure: @escaping UISliderValueChangedAction) {
        objc_setAssociatedObject(self, &UISlider.key, closure, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        removeTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
        addTarget(self, action: #selector(valueChangedAction), for: .valueChanged)
    }
    
    @objc func valueChangedAction() {
        let action: UISliderValueChangedAction? = objc_getAssociatedObject(self, &UISlider.key) as! UISliderValueChangedAction?
        action!(self)
    }
}

