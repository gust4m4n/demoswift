import UIKit
import SDWebImage

extension UIImage {
    
    func cache(key: String) {
        SDImageCache.shared.store(self, forKey: key)
    }
    
    static func cached(key: String) -> UIImage? {
        return SDImageCache.shared.imageFromCache(forKey: key)
    }
    
}
