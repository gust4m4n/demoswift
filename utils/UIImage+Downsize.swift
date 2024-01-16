import UIKit

extension UIImage {
    
    func downsize(maxSize: CGSize) -> UIImage {
        if self.size.width > maxSize.width || self.size.height > maxSize.height {
            let horizontalRatio = maxSize.width / size.width
            let verticalRatio = maxSize.height / size.height
            let ratio = min(horizontalRatio, verticalRatio)
            let newSize = CGSize(width: floor(round(size.width * ratio)), height: floor(round(size.height * ratio)))
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
            if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return newImage
            } else {
                return self
            }
        } else {
            return self
        }
    }

}
