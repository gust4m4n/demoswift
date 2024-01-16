import UIKit

protocol BackspaceTextFieldDelegate: AnyObject {
    func textFieldDidBackspace(_ textField: BackspaceTextField)
}

class BackspaceTextField: UITextField {

    weak var backspaceDelegate: BackspaceTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        backspaceDelegate?.textFieldDidBackspace(self)
    }

}
