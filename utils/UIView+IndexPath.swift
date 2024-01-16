import UIKit

extension UIView {
    
    static var indexPathKey = "indexPathKey"
    func setIndexPath(_ indexPath: IndexPath) {
        objc_setAssociatedObject(self, &UIView.indexPathKey, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func indexPath() -> IndexPath {
        return objc_getAssociatedObject(self, &UIView.indexPathKey) as! IndexPath
    }


}
