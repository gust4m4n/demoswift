import UIKit

extension String {
    func isPercentEncoded() -> Bool {
        return self.removingPercentEncoding != self
    }
    
    func urlString() -> String {
        if self.count > 0 {
            var ret = self
            while ret.isPercentEncoded() == true {
                if let s = ret.removingPercentEncoding {
                    ret = s
                }
            }
            if let s = ret.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                ret = s
            }
            return ret            
        }
        return self
    }
}

