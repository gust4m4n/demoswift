private var kAssociationKeyMaxLength: Int = 0

extension UITextField {

@IBInspectable var maxLength: Int {
    get {
        if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
            return length
        } else {
            return Int.max
        }
    }
    set {
        objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
        self.addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
    }
}

func isInputMethod() -> Bool {
    if let positionRange = self.markedTextRange {
        if let _ = self.position(from: positionRange.start, offset: 0) {
            return true
        }
    }
    return false
}


@objc func checkMaxLength(textField: UITextField) {
    
    guard !self.isInputMethod(), let prospectiveText = self.text,
        prospectiveText.count > maxLength
        else {
            return
    }
    
    let selection = selectedTextRange
    let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
    text = prospectiveText.substring(to: maxCharIndex)
    selectedTextRange = selection
  }

}

