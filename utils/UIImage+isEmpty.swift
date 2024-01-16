import UIKit

extension UIImage {
    
    func isEmpty() -> Bool {
        if self.cgImage == nil && self.ciImage == nil {
            return true
        } else {
            return false
        }
    }

}
