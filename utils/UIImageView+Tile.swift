import UIKit

extension UIImageView {
    
    func tilingImage(img: UIImage) {
        self.backgroundColor = UIColor(patternImage: img)
    }

}
