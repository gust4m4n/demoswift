import UIKit

extension UIImage {
    
    var template: UIImage? {
         return self.withRenderingMode(.alwaysTemplate)
    }

}
