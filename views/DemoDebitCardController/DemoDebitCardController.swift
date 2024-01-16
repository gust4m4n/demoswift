import UIKit

class DemoDebitCardController: UIViewController {
    @IBOutlet var containerAccount: UIView!
    @IBOutlet var containerDebit1: UIView!
    @IBOutlet var containerDebit2: UIView!
    @IBOutlet var containerDebit3: UIView!
    @IBOutlet var containerDebit4: UIView!
    @IBOutlet var containerPin1: UIView!
    @IBOutlet var containerPin2: UIView!
    @IBOutlet var containerPin3: UIView!
    @IBOutlet var containerPin4: UIView!
    @IBOutlet var containerPin5: UIView!
    @IBOutlet var containerPin6: UIView!

    @IBOutlet var txtAccount: BackspaceTextField!

    @IBOutlet var txtDebit1: BackspaceTextField!
    @IBOutlet var txtDebit2: BackspaceTextField!
    @IBOutlet var txtDebit3: BackspaceTextField!
    @IBOutlet var txtDebit4: BackspaceTextField!

    @IBOutlet var txtPin1: BackspaceTextField!
    @IBOutlet var txtPin2: BackspaceTextField!
    @IBOutlet var txtPin3: BackspaceTextField!
    @IBOutlet var txtPin4: BackspaceTextField!
    @IBOutlet var txtPin5: BackspaceTextField!
    @IBOutlet var txtPin6: BackspaceTextField!
    
    @IBOutlet var btnNext: UIButton!
    
    var newDevice = true
    var phone = ""
    var name = ""
    var pin = String()
    var passwordText = String()
    var password: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.isEnabled = false
        btnNext.alpha = 0.5        
        
        self.txtAccount.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtDebit1.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtDebit2.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtDebit3.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtDebit4.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtPin1.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtPin2.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtPin3.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtPin4.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtPin5.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }
        self.txtPin6.addDoneButtonOnKeyboard {[weak self] in
            self?.view.endEditing(true)
        }

        self.txtAccount.backspaceDelegate = self
        self.txtDebit1.backspaceDelegate = self
        self.txtDebit2.backspaceDelegate = self
        self.txtDebit3.backspaceDelegate = self
        self.txtDebit4.backspaceDelegate = self
        self.txtPin1.backspaceDelegate = self
        self.txtPin2.backspaceDelegate = self
        self.txtPin3.backspaceDelegate = self
        self.txtPin4.backspaceDelegate = self
        self.txtPin5.backspaceDelegate = self
        self.txtPin6.backspaceDelegate = self

        self.validate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnForgotClicked(_ sender: UIButton?) {
        self.view.endEditing(true)
    }
    
    func enableNextButton(on: Bool) {
        self.btnNext.isEnabled = on
        if on == true {
            self.btnNext.setBackgroundColor(UIColor(hex: 0x0C80EF), for: .normal)
        } else {
            self.btnNext.setBackgroundColor(UIColor(hex: 0xDADADA), for: .normal)
        }
    }
    
    func validate() {
        if let accountNumber = self.txtAccount.text {
            if accountNumber.count < 11 {
                enableNextButton(on: false)
                return
            }
        } else {
            enableNextButton(on: false)
            return
        }
        let debitCard = "\(txtDebit1.text ?? "")\(txtDebit2.text ?? "" )\(txtDebit3.text ?? "")\(txtDebit4.text ?? "")"
        if debitCard.count < 16 {
            enableNextButton(on: false)
            return
        }
        let pin = "\(txtPin1.text ?? "")\(txtPin2.text ?? "" )\(txtPin3.text ?? "")\(txtPin4.text ?? "")\(txtPin5.text ?? "")\(txtPin6.text ?? "")"
        if pin.count < 6 {
            enableNextButton(on: false)
            return
        }
        enableNextButton(on: true)
    }
    
    @IBAction func btnNextClicked(_ sender: UIButton?) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension DemoDebitCardController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.txtAccount {
            self.containerAccount.borderWidth = 1.5
            self.containerAccount.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtDebit1 {
            self.containerDebit1.borderWidth = 1.5
            self.containerDebit1.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtDebit2 {
            self.containerDebit2.borderWidth = 1.5
            self.containerDebit2.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtDebit3 {
            self.containerDebit3.borderWidth = 1.5
            self.containerDebit3.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtDebit4 {
            self.containerDebit4.borderWidth = 1.5
            self.containerDebit4.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtPin1 {
            self.containerPin1.borderWidth = 1.5
            self.containerPin1.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtPin2 {
            self.containerPin2.borderWidth = 1.5
            self.containerPin2.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtPin3 {
            self.containerPin3.borderWidth = 1.5
            self.containerPin3.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtPin4 {
            self.containerPin4.borderWidth = 1.5
            self.containerPin4.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtPin5 {
            self.containerPin5.borderWidth = 1.5
            self.containerPin5.borderColor = UIColor(hex: 0x0C80EF)
        } else
        if textField == self.txtPin6 {
            self.containerPin6.borderWidth = 1.5
            self.containerPin6.borderColor = UIColor(hex: 0x0C80EF)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.txtAccount {
            self.containerAccount.borderWidth = 1.0
            self.containerAccount.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtDebit1 {
            self.containerDebit1.borderWidth = 1.0
            self.containerDebit1.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtDebit2 {
            self.containerDebit2.borderWidth = 1.0
            self.containerDebit2.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtDebit3 {
            self.containerDebit3.borderWidth = 1.0
            self.containerDebit3.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtDebit4 {
            self.containerDebit4.borderWidth = 1.0
            self.containerDebit4.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtPin1 {
            self.containerPin1.borderWidth = 1.0
            self.containerPin1.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtPin2 {
            self.containerPin2.borderWidth = 1.0
            self.containerPin2.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtPin3 {
            self.containerPin3.borderWidth = 1.0
            self.containerPin3.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtPin4 {
            self.containerPin4.borderWidth = 1.0
            self.containerPin4.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtPin5 {
            self.containerPin5.borderWidth = 1.0
            self.containerPin5.borderColor = UIColor(hex: 0xCACACA)
        } else
        if textField == self.txtPin6 {
            self.containerPin6.borderWidth = 1.0
            self.containerPin6.borderColor = UIColor(hex: 0xCACACA)
        }
        self.validate()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.hasPrefix(" ") {
            return false
        }
        let count = newString.length
        
        if textField == self.txtAccount {
            if count > 11 {
                self.txtDebit1.becomeFirstResponder()
                return false
            }
        }
        else
        if textField == self.txtDebit1 || textField == self.txtDebit2 || textField == self.txtDebit3 || textField == self.txtDebit4 {
            if count > 4 {
                if textField == self.txtDebit1 {
                    self.txtDebit2.becomeFirstResponder()
                } else
                if textField == self.txtDebit2 {
                    self.txtDebit3.becomeFirstResponder()
                } else
                if textField == self.txtDebit3 {
                    self.txtDebit4.becomeFirstResponder()
                } else
                if textField == self.txtDebit4 {
                    self.txtPin1.becomeFirstResponder()
                }
                return false
            }
        }
        else
        if textField == self.txtPin1 || textField == self.txtPin2 || textField == self.txtPin3 || textField == self.txtPin4 || textField == self.txtPin5 || textField == self.txtPin6{
            if count > 1 {
                if textField == self.txtPin1 {
                    self.txtPin2.becomeFirstResponder()
                } else
                if textField == self.txtPin2 {
                    self.txtPin3.becomeFirstResponder()
                } else
                if textField == self.txtPin3 {
                    self.txtPin4.becomeFirstResponder()
                } else
                if textField == self.txtPin4 {
                    self.txtPin5.becomeFirstResponder()
                } else
                if textField == self.txtPin5 {
                    self.txtPin6.becomeFirstResponder()
                } else
                if textField == self.txtPin6 {
                    self.view.endEditing(true)
                }

                return false
            }
        }

        self.validate()
        return true
    }
        
    @IBAction func textFieldEditingChanged(_ textField: UITextField) {
        let count = textField.text?.count
        if textField == self.txtAccount && count == 11 {
            self.txtDebit1.becomeFirstResponder()
        } else
        if textField == self.txtDebit1 && count == 4 {
            self.txtDebit2.becomeFirstResponder()
        } else
        if textField == self.txtDebit2 && count == 4 {
            self.txtDebit3.becomeFirstResponder()
        } else
        if textField == self.txtDebit3 && count == 4 {
            self.txtDebit4.becomeFirstResponder()
        } else
        if textField == self.txtDebit4 && count == 4 {
            self.txtPin1.becomeFirstResponder()
        } else
        if textField == self.txtPin1 && count == 1 {
            self.txtPin2.becomeFirstResponder()
        } else
        if textField == self.txtPin2 && count == 1 {
            self.txtPin3.becomeFirstResponder()
        } else
        if textField == self.txtPin3 && count == 1 {
            self.txtPin4.becomeFirstResponder()
        } else
        if textField == self.txtPin4 && count == 1 {
            self.txtPin5.becomeFirstResponder()
        } else
        if textField == self.txtPin5 && count == 1 {
            self.txtPin6.becomeFirstResponder()
        }

        if textField == self.txtDebit1 && count == 0 {
            self.txtAccount.becomeFirstResponder()
        } else
        if textField == self.txtDebit2 && count == 0 {
            self.txtDebit1.becomeFirstResponder()
        } else
        if textField == self.txtDebit3 && count == 0 {
            self.txtDebit2.becomeFirstResponder()
        } else
        if textField == self.txtDebit4 && count == 0 {
            self.txtDebit3.becomeFirstResponder()
        } else
        if textField == self.txtPin1 && count == 0 {
            self.txtDebit4.becomeFirstResponder()
        } else
        if textField == self.txtPin2 && count == 0 {
            self.txtPin1.becomeFirstResponder()
        } else
        if textField == self.txtPin3 && count == 0 {
            self.txtPin2.becomeFirstResponder()
        } else
        if textField == self.txtPin4 && count == 0 {
            self.txtPin3.becomeFirstResponder()
        } else
        if textField == self.txtPin5 && count == 0 {
            self.txtPin4.becomeFirstResponder()
        } else
        if textField == self.txtPin6 && count == 0 {
            self.txtPin5.becomeFirstResponder()
        }

        let text = textField.text
        if text?.utf16.count == 1 {
            switch textField {
            case txtPin1: txtPin2.becomeFirstResponder()
                break
            case txtPin2: txtPin3.becomeFirstResponder()
                break
            case txtPin3: txtPin4.becomeFirstResponder()
                break
            case txtPin4: txtPin5.becomeFirstResponder()
                break
            case txtPin5: txtPin6.becomeFirstResponder()
            case txtPin6: txtPin6.resignFirstResponder()
                pin = "\(txtPin1.text ?? "")\(txtPin2.text ?? "" )\(txtPin3.text ?? "")\(txtPin4.text ?? "")\(txtPin5.text ?? "")\(txtPin6.text ?? "")"
                if pin.count == 6 {
                    btnNext.isEnabled = true
                    btnNext.alpha = 1
                } /*else {
                    sheetClose(didPop: {
                        let controller = NowOTPWrongController()
                        controller.showWith(didOK: {})
                    })
                } */
            default:
                break
            }
            
            
        }
        
        self.validate()
    }
}

extension DemoDebitCardController : BackspaceTextFieldDelegate {
    
    func textFieldDidBackspace(_ textField: BackspaceTextField) {
        if textField.text == nil || textField.text!.count == 0 {
            if textField == self.txtDebit1 {
                self.txtAccount.becomeFirstResponder()
            } else
            if textField == self.txtDebit2 {
                self.txtDebit1.becomeFirstResponder()
            } else
            if textField == self.txtDebit3 {
                self.txtDebit2.becomeFirstResponder()
            } else
            if textField == self.txtDebit4 {
                self.txtDebit3.becomeFirstResponder()
            } else
            if textField == self.txtPin1 {
                self.txtDebit4.becomeFirstResponder()
            } else
            if textField == self.txtPin2 {
                self.txtPin1.becomeFirstResponder()
            } else
            if textField == self.txtPin3 {
                self.txtPin2.becomeFirstResponder()
            } else
            if textField == self.txtPin4 {
                self.txtPin3.becomeFirstResponder()
            } else
            if textField == self.txtPin5 {
                self.txtPin4.becomeFirstResponder()
            } else
            if textField == self.txtPin6 {
                self.txtPin5.becomeFirstResponder()
            }
            self.validate()
        }
    }
    
}


