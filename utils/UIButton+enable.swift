import UIKit

extension UIButton {
    
    func enable(on: Bool, backgroundColor: UIColor? = nil) {
        self.isEnabled = on
        if backgroundColor == nil {
            if on == true {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1.0)
            } else {
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
            }
        } else {
            self.backgroundColor = backgroundColor
        }
    }
    
}


